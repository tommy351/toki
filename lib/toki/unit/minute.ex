defmodule Toki.Unit.Minute do
  @moduledoc false
  use Toki.Unit
  import Toki.DateTime

  pattern "mm", "[0-5][0-9]"
  pattern "m",  "[0-5]?[0-9]"

  parse "mm", &Toki.Unit.Minute.parse_minute/2
  parse "m",  &Toki.Unit.Minute.parse_minute/2

  format "mm", "~2..0B", &Toki.DateTime.get_minute/1
  format "m",  "~B",     &Toki.DateTime.get_minute/1

  def get(%Toki.DateTime{minute: minute}), do: minute

  def set(date, value) when is_integer(value) and value in 0..59 do
    %{date | minute: value}
  end

  def add(date, value) when is_integer(value) do
    minute = get_minute(date) + value
    {hour, minute} = Toki.Util.positive_rem(minute, 60)

    date
    |> add_hour(hour)
    |> set_minute(minute)
  end

  def parse_minute(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 0..59 -> Toki.DateTime.set_minute(date, int)
    end
  end
end
