defmodule Notioner.Database do
  @moduledoc """
  Notion database
  """

  require Logger

  @default_page_size 20
  @max_page_size 100

  @doc """
  Retrieve a database
  https://developers.notion.com/reference/retrieve-a-database
  """
  def get(db_id \\ get_db_id()) do
    db_id = get_db_id(db_id)

    Notioner.req_get!("/databases/#{db_id}")
    |> Map.get(:body)
  end

  @doc """
  Get database schema in human friendly format
  """
  def get_schema(db_id \\ get_db_id()) do
    db_id
    |> get_db_id()
    |> get()
    |> parse_schema()
  end

  def schema(db_id \\ get_db_id()), do: get_schema(db_id)

  @doc """
  Query database rows as Notion Pages

  Support options: 
  - filter
  - sorts
  - page_size: 10 # as default, 100 is max
  - start_cursor
  - filter_properties

  https://developers.notion.com/reference/post-database-query
  """
  def query(db_id \\ get_db_id(), req_opts \\ []) when is_list(req_opts) do
    db_id = get_db_id(db_id)

    filter_properties =
      case req_opts[:filter_properties] do
        nil ->
          ""

        items when is_list(items) ->
          "?" <>
            (items
             |> Enum.map(fn it -> "filter_properties=#{it}" end)
             |> Enum.join("&"))

        item when is_binary(item) ->
          "?#{item}"
      end

    req_body =
      req_opts
      |> Keyword.take([:filter, :sorts, :start_cursor, :page_size])
      |> Keyword.put_new(:page_size, @default_page_size)
      |> Map.new()

    Notioner.req_post!("/databases/#{db_id}/query#{filter_properties}", json: req_body)
    |> Map.get(:body)
  end

  def rows(db_id \\ get_db_id(), opts \\ [page_size: 5]), do: get_rows(db_id, opts)

  def get_rows(db_id \\ get_db_id(), opts \\ []) when is_list(opts) do
    query(db_id, opts)
    |> Notioner.get_results()
    |> Enum.map(&parse_row/1)
  end

  def all_rows(db_id \\ get_db_id(), opts \\ []) when is_list(opts) do
    opts =
      opts
      |> Keyword.put_new(:page_size, @max_page_size)
      |> Keyword.put_new(:filter_properties, ["title"])

    paginate_query(db_id, opts, %{}, [], fn acc, items ->
      acc ++ items
    end)
  end

  def total_count(db_id \\ get_db_id(), opts \\ []) when is_list(opts) do
    opts =
      opts
      |> Keyword.put_new(:page_size, @max_page_size)
      |> Keyword.put_new(:filter_properties, ["title"])

    paginate_query(db_id, opts, %{}, 0, fn acc, items -> acc + length(items) end)
  end

  def paginate_query(_db_id, _opts, %{"has_more" => false}, acc, _reducer), do: acc

  def paginate_query(db_id, opts, %{} = params, acc, reducer) do
    new_opts =
      case params["next_cursor"] do
        nil -> opts
        next_cursor -> opts |> Keyword.put(:start_cursor, next_cursor)
      end

    %{
      "object" => "list",
      "results" => items
    } = next_info = query(db_id, new_opts)

    next_params = Map.take(next_info, ["has_more", "next_cursor"])
    acc = reducer.(acc, items)
    paginate_query(db_id, opts, next_params, acc, reducer)
  end

  def get_db_id(_db_id \\ :default)
  def get_db_id(id) when is_atom(id), do: granted_databases() |> Map.get(id)
  def get_db_id(id) when is_binary(id), do: id

  # NOTE: databases should shared with integration!
  def granted_databases do
    Application.get_env(:notioner, :granted_databases, %{})
  end

  def parse_schema(info) when is_map(info) do
    %{
      # "archived" => false,
      # "cover" => nil,
      # "created_by" => %{
      #   "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
      #   "object" => "user"
      # },
      # "created_time" => "2019-11-13T05:33:00.000Z",
      # "description" => [
      #   %{
      #     "annotations" => %{
      #       "bold" => false,
      #       "code" => false,
      #       "color" => "default",
      #       "italic" => false,
      #       "strikethrough" => false,
      #       "underline" => false
      #     },
      #     "href" => nil,
      #     "plain_text" => "My reading list",
      #     "text" => %{"content" => "My reading list", "link" => nil},
      #     "type" => "text"
      #   }
      # ],
      # "icon" => %{"emoji" => "📚", "type" => "emoji"},
      # "id" => "408b771f-00ff-409e-8bca-b2c6c609b2a9",
      "id" => id,
      # "in_trash" => false,
      # "is_inline" => false,
      # "last_edited_by" => %{
      #   "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
      #   "object" => "user"
      # },
      # "last_edited_time" => "2024-12-20T02:10:00.000Z",
      "object" => "database",
      # "parent" => %{"type" => "workspace", "workspace" => true},
      "properties" => properties,
      "public_url" => public_url,
      # "request_id" => "bc8fab38-cd47-44c4-be28-fd2690b71372",
      "title" => [
        %{
          # "annotations" => %{
          #   "bold" => false,
          #   "code" => false,
          #   "color" => "default",
          #   "italic" => false,
          #   "strikethrough" => false,
          #   "underline" => false
          # },
          # "href" => nil,
          "plain_text" => title_content,
          # "text" => %{
          #   "content" => "ReadingList",
          #   "link" => nil
          # },
          "type" => "text"
        }
      ],
      "url" => url
    } = info

    %{
      id: id,
      url: url,
      title: title_content,
      public_url: public_url,
      properties:
        properties
        |> Map.values()
        |> Enum.map(&get_prop_item/1)
    }
  end

  def get_prop_item(%{
        "id" => id,
        "multi_select" => %{"options" => options},
        "name" => name,
        "type" => "multi_select" = type
      }) do
    mini_options =
      Enum.map(options, fn %{"name" => name, "id" => _id} -> name end)

    {name, type, %{id: id, options: mini_options}}
  end

  def get_prop_item(%{
        "id" => id,
        "select" => %{"options" => options},
        "name" => name,
        "type" => "select" = type
      }) do
    mini_options =
      Enum.map(options, fn %{"name" => name, "id" => _id} -> name end)

    {name, type, %{id: id, options: mini_options}}
  end

  def get_prop_item(%{
        "id" => id,
        "status" => %{"options" => options},
        "name" => name,
        "type" => "status" = type
      }) do
    mini_options =
      Enum.map(options, fn %{"name" => name, "id" => _id} -> name end)

    {name, type, %{id: id, options: mini_options}}
  end

  def get_prop_item(%{
        "id" => id,
        "name" => name,
        # "title" => %{},
        # "type" => "title"
        "type" => type
      }) do
    {name, type, %{id: id}}
  end

  def parse_row(info) when is_map(info) do
    %{
      # "archived" => false,
      # "cover" => nil,
      # "created_by" => %{
      #   "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
      #   "object" => "user"
      # },
      # "created_time" => "2024-12-17T03:17:00.000Z",
      # "icon" => %{
      #   "external" => %{"url" => "https://www.notion.so/icons/target_lightgray.svg"},
      #   "type" => "external"
      # },
      "id" => id,
      # "in_trash" => false,
      # "last_edited_by" => %{
      #   "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
      #   "object" => "user"
      # },
      # "last_edited_time" => "2024-12-17T03:18:00.000Z",
      "object" => "page",
      # "parent" => %{
      #   "database_id" => "fd0d6c70-54d7-462a-ac95-5d25a9c0af7b",
      #   "type" => "database_id"
      # },
      "properties" => properties,
      "public_url" => _public_url,
      "url" => _url
    } = info

    cols =
      properties
      |> Enum.map(&get_row_item/1)

    [{"ID__", id, %{type: "builtin"}} | cols]
  end

  def get_row_item({name,
       %{
         "id" => id,
         "title" => [
           %{
             # "annotations" => %{
             #   "bold" => false,
             #   "code" => false,
             #   "color" => "default",
             #   "italic" => false,
             #   "strikethrough" => false,
             #   "underline" => false
             # },
             #  "href" => nil,
             "plain_text" => value,
             #  "text" => %{"content" => "Notioner-db-pretty rows", "link" => nil},
             "type" => "text"
           }
         ],
         "type" => "title" = type
       } = _row}) do
    {name, value, %{id: id, type: type}}
  end

  def get_row_item(
        {name,
         %{
           "id" => id,
           "rich_text" => texts,
           "type" => "rich_text" = type
         } = _row}
      ) do
    value =
      texts
      |> Enum.map(fn
        %{
          #  "annotations" => %{
          #    "bold" => false,
          #    "code" => false,
          #    "color" => "default",
          #    "italic" => false,
          #    "strikethrough" => false,
          #    "underline" => false
          #  },
          # "href" => nil,
          "plain_text" => value,
          # "text" => %{"content" => "Notioner-db-pretty rows", "link" => nil},
          "type" => "text"
        } ->
          value
      end)
      |> Enum.join("\n ")

    {name, value, %{id: id, type: type}}
  end

  def get_row_item({name,
       %{
         "id" => id,
         "status" => %{
           #  "color" => "blue",
           #  "id" => "in-progress",
           "name" => value
         },
         "type" => "status" = type
       } = _row}) do
    {name, value, %{id: id, type: type}}
  end

  def get_row_item(
        {name,
         %{
           "id" => id,
           "formula" => %{
             "string" => value,
             "type" => "string"
           },
           "type" => "formula" = type
         } = _row}
      ) do
    {name, value, %{id: id, type: type}}
  end

  def get_row_item({name,
       %{
         "id" => id,
         #  "unique_id" => %{"number" => 227, "prefix" => nil},
         "type" => "unique_id" = type
       } = row}) do
    value = row[type]
    {name, value, %{id: id, type: type}}
  end

  def get_row_item(
        {name,
         %{
           "id" => id,
           "relation" => _relation_array,
           "type" => "relation" = type
         } = _row}
      ) do
    {name, :not_supported_releation_array, %{id: id, type: type}}
  end

  def get_row_item(
        {name,
         %{
           "id" => id,
           "type" => type
         } = row}
      ) do
    value = row[type]
    {name, value, %{id: id, type: type}}
  end
end
