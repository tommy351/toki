defmodule Toki.Unit.Year do
  @moduledoc false
  use Toki.Unit
  import Toki.DateTime

  pattern "YYYY","\\d{4}"
  pattern "Y",   "\\d{1,4}"

  parse "YYYY", &Toki.Unit.Year.parse_year/2
  parse "Y",    &Toki.Unit.Year.parse_year/2

  format "YYYY", "~4..0B", &Toki.DateTime.get_year/1
  format "Y",    "~B",     &Toki.DateTime.get_year/1

  def get(%Toki.DateTime{year: year}), do: year

  def set(%Toki.DateTime{} = date, value) when is_integer(value) do
    date = %{date | year: value}
    set_month(date, get_month(date))
  end

  def add(date, value) when is_integer(value) do
    set_year(date, get_year(date) + value)
  end

  def parse_year(value, date) do
    {int, ""} = Integer.parse(value)
    set_year(date, int)
  end
end
