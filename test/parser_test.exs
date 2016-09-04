defmodule Toki.ParserTest do
  use ExUnit.Case

  @tests [
    # Basic
    {"2015-06-07", "YYYY-MM-DD", %Toki.DateTime{year: 2015, month: 6, day: 7}},
    {"15:16:17", "HH:mm:ss", %Toki.DateTime{hour: 15, minute: 16, second: 17}},
    # With non-token characters
    {"Today is 6/7", "[Today is ]M/D", %Toki.DateTime{month: 6, day: 7}}
  ]

  test "parse" do
    for {value, pattern, expected} <- @tests do
      assert Toki.Parser.parse(value, pattern) == expected
    end
  end
end
