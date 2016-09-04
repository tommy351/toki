defmodule Toki.Unit.MonthTest do
  use ExUnit.Case

  test "get" do
    assert Toki.Unit.Month.get(%Toki.DateTime{month: 3}) == 3
  end

  test "set" do
    date = Toki.Unit.Month.set(%Toki.DateTime{year: 2016, month: 3, day: 31}, 6)
    assert date == %Toki.DateTime{year: 2016, month: 6, day: 30}
  end

  test "add" do
    date = Toki.Unit.Month.add(%Toki.DateTime{year: 2016, month: 3, day: 31}, 3)
    assert date == %Toki.DateTime{year: 2016, month: 6, day: 30}
  end

  test "subtract" do
    date = Toki.Unit.Month.add(%Toki.DateTime{year: 2016, month: 3, day: 31}, -18)
    assert date == %Toki.DateTime{year: 2014, month: 9, day: 30}
  end

  test "parse_month" do
    assert Toki.Unit.Month.parse_month("6", %Toki.DateTime{}) == %Toki.DateTime{month: 6}
  end
end
