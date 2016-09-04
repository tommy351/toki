defmodule Toki.Formatter do
  use Toki.Unit.Year,   :format
  use Toki.Unit.Month,  :format
  use Toki.Unit.Day,    :format
  use Toki.Unit.Hour,   :format
  use Toki.Unit.Minute, :format
  use Toki.Unit.Second, :format

  @spec format(Toki.DateTime.t, String.t) :: String.t
  def format(date, pattern) do
    do_format(pattern, date, "", [])
  end

  defp do_format("", _, format, values) do
    :io_lib.format(:unicode.characters_to_list(format), Enum.reverse(values))
    |> :erlang.iolist_to_binary
  end

  defp do_format("[" <> rest, date, format, values) do
    [str, rest] = case String.split(rest, "]", parts: 2) do
      [str, rest] -> [str, rest]
      [rest] -> ["[", rest]
    end

    do_format(rest, date, format <> str, values)
  end

  defp do_format(<<h::binary-size(1), rest::binary>>, date, format, values) do
    do_format(rest, date, format <> h, values)
  end
end
