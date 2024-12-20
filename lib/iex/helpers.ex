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

  ## todo how trigger fmt in iex session
end
