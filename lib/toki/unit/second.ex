defmodule Toki.Unit.Second do
  use Toki.Unit

  pattern "ss", "[0-5][0-9]"
  pattern "s",  "[0-5]?[0-9]"

  parse "ss", &Toki.Unit.Second.parse_second/2
  parse "s",  &Toki.Unit.Second.parse_second/2

  format "ss", "~2..0B", &Toki.DateTime.get_second/1
  format "s",  "~B",     &Toki.DateTime.get_second/1

  def get(%Toki.DateTime{second: second}), do: second
  def set(%Toki.DateTime{} = date, second) when is_integer(second) and second in 0..59 do
    %{date | second: second} 
  end

  def parse_second(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 0..59 -> Toki.DateTime.set_second(date, int)
    end
  end
end
