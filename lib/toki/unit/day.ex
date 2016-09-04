defmodule Toki.Unit.Day do
  use Toki.Unit

  pattern "DD", "0[1-9]|[12][0-9]|3[0-1]"
  pattern "D",  "0?[1-9]|[12][0-9]|3[0-1]"

  parse "DD", &Toki.Unit.Day.parse_day/2
  parse "D",  &Toki.Unit.Day.parse_day/2

  format "DD", "~2..0B", &Toki.DateTime.get_day/1
  format "D",  "~B",     &Toki.DateTime.get_day/1

  def get(%Toki.DateTime{day: day}), do: day
  def set(%Toki.DateTime{} = date, day) when is_integer(day) and day in 1..31 do
    %{date | day: day} 
  end

  def parse_day(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 1..31 -> Toki.DateTime.set_day(date, int)
    end
  end
end
