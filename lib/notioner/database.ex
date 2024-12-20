defmodule Notioner.Database do
  @moduledoc """
  Notion database

  todo:
  - total rows count
  """

  # NOTE: databases should shared with integration!
  def granted_databases do
    Application.get_env(:notioner, :granted_databases, %{})
  end

  def get(db_id \\ get_db_id()) do
    db_id = get_db_id(db_id)

    Notioner.req_get!("/databases/#{db_id}")
    |> Map.get(:body)
  end

  def query(db_id \\ get_db_id(), req_body \\ %{page_size: 10}) do
    db_id = get_db_id(db_id)

    Notioner.req_post!("/databases/#{db_id}/query?filter_properties=title", json: req_body)
    |> Map.get(:body)
  end

  def get_db_id(_db_id \\ :run_man_tasks)
  def get_db_id(id) when is_atom(id), do: granted_databases() |> Map.get(id)
  def get_db_id(id) when is_binary(id), do: id

  @doc """
  Get human friendly db schema info
  """
  def schema_info(db_id \\ get_db_id()) do
    db_id
    |> get_db_id()
    |> get()
    |> parse_schema()
  end

  def parse_schema(info \\ demo_db_schema()) when is_map(info) do
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
          # "plain_text" => "ReadingList",
          "text" => %{
            "content" => title_content
            # "link" => nil
          },
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
        # "id" => _id,
        "multi_select" => %{"options" => options},
        "name" => name,
        "type" => "multi_select" = type
      }) do
    mini_options =
      Enum.map(options, fn %{"name" => name, "id" => _id} -> name end)

    {name, type, %{options: mini_options}}
  end

  def get_prop_item(%{
        # "id" => _id,
        "select" => %{"options" => options},
        "name" => name,
        "type" => "select" = type
      }) do
    mini_options =
      Enum.map(options, fn %{"name" => name, "id" => _id} -> name end)

    {name, type, %{options: mini_options}}
  end

  def get_prop_item(%{
        # "id" => _id,
        "status" => %{"options" => options},
        "name" => name,
        "type" => "status" = type
      }) do
    mini_options =
      Enum.map(options, fn %{"name" => name, "id" => _id} -> name end)

    {name, type, %{options: mini_options}}
  end

  def get_prop_item(%{
        "id" => _,
        "name" => name,
        # "title" => %{},
        # "type" => "title"
        "type" => type
      }) do
    {name, type, %{}}
  end

  def demo_db_schema do
    :code.priv_dir(:notioner)
    |> to_string
    |> Path.join("/data/demo-db-schema.json")
    |> File.read!()
    |> JSON.decode!()
  end
end
