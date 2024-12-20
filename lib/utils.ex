defmodule Notioner.Utils do
  @moduledoc """
  Util helpers
  """

  ## Timing

  defdelegate utc_now(), to: DateTime
  def now, do: utc_now()

  # https://hexdocs.pm/elixir/1.17.2/System.html#t:time_unit/0
  # unit: :day | :hour | :minute | :second | :millisecond | :microsecond | :nanosecond | pos_integer()
  @spec diff_time(Calendar.datetime(), keyword()) :: integer()
  def diff_time(from, opts \\ []), do: DateTime.diff(now(), from, opts[:unit] || :millisecond)
end
