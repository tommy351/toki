defmodule Toki do
  @spec parse(String.t, String.t) :: Toki.DateTime.t
  def parse(value, pattern) do
    Toki.Parser.parse(value, pattern)
  end

  @spec now() :: Toki.DateTime.t
  def now() do
    :erlang.timestamp()
    |> Toki.DateTime.from_erlang_timestamp
  end
end
