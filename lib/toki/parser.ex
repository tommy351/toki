defmodule Toki.Parser do
  use Toki.Unit.Year,   :parse
  use Toki.Unit.Month,  :parse
  use Toki.Unit.Day,    :parse
  use Toki.Unit.Hour,   :parse
  use Toki.Unit.Minute, :parse
  use Toki.Unit.Second, :parse

  @spec parse(String.t, String.t) :: Toki.DateTime
  def parse(value, pattern) do
    Toki.Pattern.compile(pattern)
    |> Regex.named_captures(value)
    |> Map.to_list
    |> do_parse(%Toki.DateTime{})
  end

  defp do_parse([], date) do
    date
  end
end
