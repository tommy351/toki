defmodule Toki.Pattern do
  use Toki.Unit.Year,   :compile
  use Toki.Unit.Month,  :compile
  use Toki.Unit.Day,    :compile
  use Toki.Unit.Hour,   :compile
  use Toki.Unit.Minute, :compile
  use Toki.Unit.Second, :compile

  @spec compile(String.t) :: Regex.t
  def compile(pattern) do
    do_compile(pattern, "")
  end

  defp do_compile("", acc) do
    {:ok, regex} = Regex.compile("^#{acc}$")
    regex
  end

  defp do_compile("[" <> rest, acc) do
    [str, rest] = case String.split(rest, "]", parts: 2) do
      [str, rest] -> [str, rest]
      [rest] -> ["[", rest]
    end

    do_compile(rest, acc <> Regex.escape(str))
  end

  defp do_compile(<<h::binary-size(1), rest::binary>>, acc) do
    do_compile(rest, acc <> Regex.escape(h))
  end
end
