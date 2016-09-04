defmodule Toki.Pattern do
  use Toki.Unit.Year, :compile

  @spec compile(String.t) :: Regex.t
  def compile(pattern) do
    do_compile(pattern, "")
  end

  defp do_compile("", acc) do
    {:ok, regex} = Regex.compile("^#{acc}$")
    regex
  end
end
