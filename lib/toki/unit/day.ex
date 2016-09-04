defmodule Toki.Unit.Day do
  @moduledoc false
  use Toki.Unit
  import Toki.DateTime

  pattern "DD", "0[1-9]|[12][0-9]|3[0-1]"
  pattern "D",  "0?[1-9]|[12][0-9]|3[0-1]"

  parse "DD", &Toki.Unit.Day.parse_day/2
  parse "D",  &Toki.Unit.Day.parse_day/2

  format "DD", "~2..0B", &Toki.DateTime.get_day/1
  format "D",  "~B",     &Toki.DateTime.get_day/1

  def get(%Toki.DateTime{day: day}), do: day

  def set(date, value) when is_integer(value) and value in 1..31 do
    last_day = :calendar.last_day_of_the_month(get_year(date), get_month(date))
    day = Enum.min([last_day, value])

    %{date | day: day}
  end

  def add(date, value) when is_integer(value) do
    {y, m, d} = Toki.Util.day_number(get_year(date), get_month(date), get_day(date)) + value
    |> Toki.Util.date

    %{date | year: y, month: m, day: d}
  end

  def parse_day(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 1..31 -> Toki.DateTime.set_day(date, int)
    end
  end
end
