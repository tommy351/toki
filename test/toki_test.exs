defmodule TokiTest do
  use ExUnit.Case
  doctest Toki

  test "the truth" do

    date = Toki.parse("2015", "YYYY")
    IO.inspect Toki.DateTime.format date, "YYYY"

    assert 1 + 1 == 2
  end
end
