defmodule Toki.Unit.Hour do
  @moduledoc false
  use Toki.Unit
  import Toki.DateTime

  pattern "HH", "[0-1][0-9]|2[0-3]"
  pattern "H",  "[0-1]?[0-9]|2[0-3]"

  parse "HH", &Toki.Unit.Hour.parse_hour/2
  parse "H",  &Toki.Unit.Hour.parse_hour/2

  format "HH", "~2..0B", &Toki.DateTime.get_hour/1
  format "H",  "~B",     &Toki.DateTime.get_hour/1

  def get(%Toki.DateTime{hour: hour}), do: hour

  def set(date, value) when is_integer(value) and value in 0..23 do
    %{date | hour: value}
  end

  def add(date, value) when is_integer(value) do
    hour = get_hour(date) + value
    {day, hour} = Toki.Util.positive_rem(hour, 24)

    date
    |> add_day(day)
    |> set_hour(hour)
  end

  def parse_hour(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 0..23 -> Toki.DateTime.set_hour(date, int)
    end
  end
end
