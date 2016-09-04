defmodule Toki.Unit.DayTest do
  use ExUnit.Case

  test "get" do
    assert Toki.Unit.Day.get(%Toki.DateTime{day: 15}) == 15
  end

  test "set" do
    date = Toki.Unit.Day.set(%Toki.DateTime{year: 2015, month: 2, day: 15}, 30)
    assert date == %Toki.DateTime{year: 2015, month: 2, day: 28}
  end

  test "add" do
    date = Toki.Unit.Day.add(%Toki.DateTime{year: 2015, month: 2, day: 15}, 15)
    assert date == %Toki.DateTime{year: 2015, month: 3, day: 2}
  end

  test "subtract" do
    date = Toki.Unit.Day.add(%Toki.DateTime{year: 2015, month: 2, day: 15}, -15)
    assert date == %Toki.DateTime{year: 2015, month: 1, day: 31}
  end

  test "parse_day" do
    assert Toki.Unit.Day.parse_day("15", %Toki.DateTime{}) == %Toki.DateTime{day: 15}
  end
end
