defmodule Toki.Unit.Minute do
  use Toki.Unit

  pattern "mm", "[0-5][0-9]"
  pattern "m",  "[0-5]?[0-9]"

  parse "mm", &Toki.Unit.Minute.parse_minute/2
  parse "m",  &Toki.Unit.Minute.parse_minute/2

  format "mm", "~2..0B", &Toki.DateTime.get_minute/1
  format "m",  "~B",     &Toki.DateTime.get_minute/1

  def get(%Toki.DateTime{minute: minute}), do: minute
  def set(%Toki.DateTime{} = date, minute) when is_integer(minute) and minute in 0..59 do
    %{date | minute: minute} 
  end

  def parse_minute(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 0..59 -> Toki.DateTime.set_minute(date, int)
    end
  end
end
