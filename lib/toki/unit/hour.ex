defmodule Toki.Unit.Hour do
  use Toki.Unit

  pattern "HH", "[0-1][0-9]|2[0-3]"
  pattern "H",  "[0-1]?[0-9]|2[0-3]"

  pattern "HH", &Toki.Unit.Hour.parse_hour/2
  pattern "H",  &Toki.Unit.Hour.parse_hour/2

  format "HH", "~2..0B", &Toki.DateTime.get_hour/1
  format "H",  "~B",     &Toki.DateTime.get_hour/1

  def get(%Toki.DateTime{hour: hour}), do: hour
  def set(%Toki.DateTime{} = date, hour) when is_integer(hour) and hour in 0..23 do
    %{date | hour: hour}
  end

  def parse_hour(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 0..23 -> Toki.DateTime.set_hour(date, int)
    end
  end
end
