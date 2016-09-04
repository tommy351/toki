defmodule TokiTest do
  use ExUnit.Case
  doctest Toki

  test "the truth" do

    IO.inspect Toki.parse("2015", "YYYY")

    assert 1 + 1 == 2
  end
end
