defmodule Toki.Unit.Month do
  use Toki.Unit

  pattern "MM", "0[1-9]|1[0-2]"
  pattern "M",  "0?[1-9]|1[0-2]"

  parse "MM", &Toki.Unit.Month.parse_month/2
  parse "M",  &Toki.Unit.Month.parse_month/2

  format "MM", "~2..0B", &Toki.DateTime.get_month/1
  format "M",  "~B",     &Toki.DateTime.get_month/1

  def get(%Toki.DateTime{month: month}), do: month
  def set(%Toki.DateTime{} = date, month) when is_integer(month) and month in 1..12 do
    %{date | month: month}
  end

  def parse_month(value, date) do
    case Integer.parse(value) do
      {int, ""} when int in 1..12 -> Toki.DateTime.set_month(date, int)
    end
  end
end
