defmodule Notioner.Page do
  @moduledoc """
  Notion Pages
  https://developers.notion.com/reference/intro#pagination
  """

  @page_title_property_id "title"

  @doc """
  Retrieve a page
  https://developers.notion.com/reference/retrieve-a-page
  """
  def get(page_id \\ get_page_id()) do
    page_id = get_page_id(page_id)

    Notioner.req_get!("/pages/#{page_id}")
    |> Map.get(:body)
  end

  @doc """
  Retrieve a page property item
  https://developers.notion.com/reference/retrieve-a-page-property

  NOTE: property_id can be property id or key name
  """
  def get_property(page_id \\ get_page_id(), property_id \\ @page_title_property_id) do
    page_id = get_page_id(page_id)

    Notioner.req_get!("/pages/#{page_id}/properties/#{property_id}")
    |> Map.get(:body)
  end

  @doc """
  Change page title or task name
  """
  def change_title(new_title, page_id \\ get_page_id(:test_sub_page)) do
    page_id = get_page_id(page_id)

    properties = %{
      "title" => %{
        "title" => [
          %{
            "text" => %{"content" => new_title}
          }
        ]
      }
    }

    Notioner.req_patch!("/pages/#{page_id}", json: %{properties: properties})
  end

  # https://www.notion.so/shareupme/RunMan-191be20465e84bd7992bd00a36565967?pvs=4
  # https://www.notion.so/shareupme/191be20465e84bd7992bd00a36565967
  # https://www.notion.so/shareupme/Test-only-task-Do-not-delete-me-160673e59ab680c0b090cf8b8b4758e0?pvs=4
  # https://www.notion.so/shareupme/Top-test-page-161673e59ab680b8b909c00f6f0b26a4?pvs=4
  # https://www.notion.so/shareupme/Test-123-161673e59ab68010ab4ce393962c5210?pvs=4
  def get_page_id(type \\ :test_task)
  def get_page_id(:test_task), do: "160673e59ab680c0b090cf8b8b4758e0"
  def get_page_id(:test_top_page), do: "161673e59ab680b8b909c00f6f0b26a4"
  def get_page_id(:test_sub_page), do: "161673e59ab68010ab4ce393962c5210"
  def get_page_id(page_id) when is_binary(page_id), do: page_id
end
