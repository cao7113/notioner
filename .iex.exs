# since v1.18+
IEx.configure(auto_reload: true)

defmodule IexHelpers do
  def blanks(n \\ 20) do
    1..n
    |> Enum.each(fn _ ->
      IO.puts("")
    end)
  end

  def load_json!(file) do
    file
    |> File.read!()
    |> Jason.decode!()
  end

  def iex_config do
    IEx.configuration()
  end
end
import IexHelpers

## project specific

alias Keyword, as: K
alias Enum, as: E
import Enum, only: [at: 2]

alias Notioner, as: N
alias Notioner.Page
alias Notioner.Database, as: Db
