defmodule Toki.Unit.HourTest do
  use ExUnit.Case

  test "get" do
    assert Toki.Unit.Hour.get(%Toki.DateTime{hour: 15}) == 15
  end

  test "set" do
    date = Toki.Unit.Hour.set(%Toki.DateTime{hour: 12}, 18)
    assert date == %Toki.DateTime{hour: 18}
  end

  test "add" do
    date = Toki.Unit.Hour.add(%Toki.DateTime{hour: 12}, 8)
    assert date == %Toki.DateTime{hour: 20}
  end

  test "subtract" do
    date = Toki.Unit.Hour.add(%Toki.DateTime{year: 2015, month: 3, day: 1, hour: 12}, -14)
    assert date == %Toki.DateTime{year: 2015, month: 2, day: 28, hour: 22}
  end

  test "parse_hour" do
    assert Toki.Unit.Hour.parse_hour("15", %Toki.DateTime{}) == %Toki.DateTime{hour: 15}
  end
end
