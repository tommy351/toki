defmodule Toki.Unit.YearTest do
  use ExUnit.Case

  test "get" do
    assert Toki.Unit.Year.get(%Toki.DateTime{year: 2015}) == 2015
  end

  test "set" do
    date = Toki.Unit.Year.set(%Toki.DateTime{year: 2016, month: 2, day: 29}, 2015)
    assert date == %Toki.DateTime{year: 2015, month: 2, day: 28}
  end

  test "add" do
    date = Toki.Unit.Year.add(%Toki.DateTime{year: 2016, month: 2, day: 29}, 3)
    assert date == %Toki.DateTime{year: 2019, month: 2, day: 28}
  end

  test "parse_year" do
    assert Toki.Unit.Year.parse_year("2015", %Toki.DateTime{}) == %Toki.DateTime{year: 2015}
  end
end
