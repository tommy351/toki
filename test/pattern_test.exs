defmodule Toki.PatternTest do
  use ExUnit.Case

  @tests [
    # Basic
    {"YYYY", "^(?<YYYY>\\d{4})$"},
    # Composition
    {"YYYY-MM-DD", "^(?<YYYY>\\d{4})-(?<MM>0[1-9]|1[0-2])-(?<DD>0[1-9]|[12][0-9]|3[0-1])$"},
    {"YYYY.MM.DD", "^(?<YYYY>\\d{4})\\.(?<MM>0[1-9]|1[0-2])\\.(?<DD>0[1-9]|[12][0-9]|3[0-1])$"},
    # Escape
    {"YYYY[MM]DD", "^(?<YYYY>\\d{4})MM(?<DD>0[1-9]|[12][0-9]|3[0-1])$"},
    {"YYYY[DD", "^(?<YYYY>\\d{4})\\[(?<DD>0[1-9]|[12][0-9]|3[0-1])$"}
  ]

  test "compile" do
    for {key, expected} <- @tests do
      assert Toki.Pattern.compile(key) == Regex.compile!(expected)
    end
  end
end
