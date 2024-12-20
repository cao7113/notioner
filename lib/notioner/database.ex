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

  @doc """
  Get human friendly db schema info
  """
  def schema_info(db_id \\ get_db_id()) do
    # todo
  end

  def query(db_id \\ get_db_id(), req_body \\ %{page_size: 10}) do
    db_id = get_db_id(db_id)

    Notioner.req_post!("/databases/#{db_id}/query?filter_properties=title", json: req_body)
    |> Map.get(:body)
  end

  def get_db_id(_db_id \\ :run_man_tasks)
  def get_db_id(id) when is_atom(id), do: granted_databases() |> Map.get(id)
  def get_db_id(id) when is_binary(id), do: id
end
