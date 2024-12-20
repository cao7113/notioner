defmodule Notioner.User do
  @moduledoc """
  Users(included bots)
  """

  @doc """
  Get notion users
  https://developers.notion.com/reference/get-users
  """
  def get_users() do
    Notioner.req_get!("/users")
    |> Map.get(:body)
  end
end
