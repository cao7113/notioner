defmodule Notioner do
  @moduledoc """
  Notion API https://developers.notion.com/reference/intro
  """

  alias Notioner.ReqClient

  def all_projects(db_id \\ :runner_projects) do
    Notioner.Database.query(db_id)
    |> get_results()
    |> Enum.map(fn m ->
      page_id = get_in(m, ["id"])

      title_content =
        get_in(m, ["properties", "Project name", "title", Access.at(0), "text", "content"])

      {title_content, page_id}
    end)
    # require "Project name" unique as title!
    |> Map.new()
  end

  @doc """
  Query tasks as notion-pages
  """
  def query_tasks(task_name_part, opts \\ []) do
    db_id = opts[:db_id] || :runner_tasks
    page_size = opts[:page_size] || 10

    req_body = %{
      filter: %{
        property: "Task name",
        title: %{
          contains: task_name_part
        }
      },
      page_size: page_size
    }

    Notioner.Database.query(db_id, req_body)
    |> get_results()
    |> Enum.map(fn m ->
      page_id = get_in(m, ["id"])

      title_content =
        get_in(m, ["properties", "Task name", "title", Access.at(0), "text", "content"])

      {page_id, title_content}
    end)
  end

  def set_task_projects(page_id, project_ids) when is_list(project_ids) do
    page_id = Notioner.Page.get_page_id(page_id)

    properties = %{
      "Project" => %{
        "relation" => project_ids |> Enum.map(fn id -> %{id: id} end)
      }
    }

    req_patch!("/pages/#{page_id}", json: %{properties: properties})
  end

  @doc """
  iex>

    Notioner.set_task_project_names :test_task, ["Plan"]
  """
  def set_task_project_names(page_id, project_names, projects \\ all_projects())
      when is_list(project_names) and is_map(projects) do
    project_ids = projects |> Map.take(project_names) |> Map.values()

    set_task_projects(page_id, project_ids)
  end

  @doc """
  todo
  - how to find all parents?
  """
  def get_parents(obj_id, type \\ :page)

  def get_parents(page_id, :page) do
    get_parent(%{"type" => "page_id", "page_id" => page_id})
  end

  def get_parents(db_id, :db) do
    get_parent(%{"type" => "database_id", "database_id" => db_id})
  end

  def get_parent(%{"type" => "database_id", "database_id" => db_id}) do
    Notioner.Database.get(db_id)
    |> match_parent()
    |> Map.fetch!("parent")
  end

  def get_parent(%{"type" => "page_id", "page_id" => page_id}) do
    Notioner.Page.get(page_id)
    |> match_parent()
    |> Map.fetch!("parent")
  end

  # this is top case, the end!
  def get_parent(%{"type" => "workspace", "workspace" => true}), do: nil

  @doc """
  Friendly handle not found
  """
  def match_parent(%{
        "code" => "object_not_found",
        "message" => msg,
        # "message" => "Could not find page with ID: 628fe830-b331-479b-98d1-d21c4b45a529. Make sure the relevant pages and databases are shared with your integration.",
        "object" => "error",
        # "request_id" => "6b64f59f-f3a6-421e-b5a4-9efaaeeb974b",
        "status" => 404
      }) do
    raise "#{msg}, open page with link: https://www.notion.so/shareupme/<obj-id> and grant connection!"
  end

  def match_parent(obj), do: obj

  ## HTTP Request

  def req_get!(path, opts \\ []),
    do: ReqClient.get!(path, Keyword.merge(default_opts(), opts))

  def req_post!(path, opts \\ []),
    do: ReqClient.post!(path, Keyword.merge(default_opts(), opts))

  def req_patch!(path, opts \\ []),
    do: ReqClient.patch!(path, Keyword.merge(default_opts(), opts))

  def get_results(resp) when is_map(resp) do
    resp
    |> Map.get("results", [])
  end

  def default_opts() do
    Application.get_env(:notioner, :notion_req_options, [])
  end
end
