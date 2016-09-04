defmodule Toki.Formatter do
  use Toki.Unit.Year, :format

  def format(date, pattern) do
    do_format(pattern, date, "", [])
  end

  defp do_format("", _, format, values) do
    :io_lib.format(String.to_charlist(format), Enum.reverse(values))
    |> :erlang.iolist_to_binary
  end
end
