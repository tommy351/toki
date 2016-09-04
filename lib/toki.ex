defmodule Toki do
  @spec parse(String.t, String.t) :: Toki.DateTime
  def parse(value, pattern) do
    Toki.Pattern.compile(pattern)
    |> Regex.named_captures(value)
  end
end
