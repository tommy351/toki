defmodule Toki.Formatter do
  use Toki.Unit.Year,   :format
  use Toki.Unit.Month,  :format
  use Toki.Unit.Day,    :format
  use Toki.Unit.Hour,   :format
  use Toki.Unit.Minute, :format
  use Toki.Unit.Second, :format

  def format(date, pattern) do
    do_format(pattern, date, "", [])
  end

  defp do_format("", _, format, values) do
    :io_lib.format(String.to_charlist(format), Enum.reverse(values))
    |> :erlang.iolist_to_binary
  end
end
