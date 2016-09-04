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
end
