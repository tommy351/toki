defmodule Toki.Unit.Month do
  @moduledoc false
  use Toki.Unit
  import Toki.DateTime

  pattern "MM", "0[1-9]|1[0-2]"
  pattern "M",  "0?[1-9]|1[0-2]"

  parse "MM", &Toki.Unit.Month.parse_month/2
  parse "M",  &Toki.Unit.Month.parse_month/2

  format "MM", "~2..0B", &Toki.DateTime.get_month/1
  format "M",  "~B",     &Toki.DateTime.get_month/1

  def get(%Toki.DateTime{month: month}), do: month

  def set(date, value) when is_integer(value) and value in 1..12 do
    date = %{date | month: value}
    set_day(date, get_day(date))
  end

  def add(date, value) when is_integer(value) do
    month = get_month(date) + value
    {year, month} = Toki.Util.positive_rem(month, 12)

    date
    |> add_year(year)
    |> set_month(month)
  end

  def parse_month(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 1..12 -> Toki.DateTime.set_month(date, int)
    end
  end
end
