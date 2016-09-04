defmodule Toki.FormatterTest do
  use ExUnit.Case

  @datetime %Toki.DateTime{
    year: 2015,
    month: 6,
    day: 7,
    hour: 15,
    minute: 16,
    second: 17
  }

  @tests [
    # Basic
    {@datetime, "YYYY", "2015"},
    # Composition
    {@datetime, "YYYY-MM-DD", "2015-06-07"},
    {@datetime, "HH:mm:ss", "15:16:17"},
    # Escape
    {@datetime, "YYYY[MM]DD", "2015MM07"},
    {@datetime, "YYYY[DD", "2015[07"}
  ]

  test "format" do
    for {date, pattern, expected} <- @tests do
      assert Toki.Formatter.format(date, pattern) == expected
    end
  end
end
