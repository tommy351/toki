defmodule Toki.Unit.Year do
  use Toki.Unit

  pattern "YYYY","\\d{4}"
  pattern "Y",   "\\d{1,4}"

  parse "YYYY", &Toki.Unit.Year.parse_year/2
  parse "Y",    &Toki.Unit.Year.parse_year/2

  format "YYYY", "~4..0B", &Toki.DateTime.get_year/1
  format "Y",    "~B",     &Toki.DateTime.get_year/1

  def get(%Toki.DateTime{year: year}), do: year
  def set(%Toki.DateTime{} = date, year) when is_integer(year), do: %{date | year: year}

  def parse_year(value, date) do
    {int, ""} = Integer.parse(value)
    Toki.DateTime.set_year(date, int)
  end
end
