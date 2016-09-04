defmodule Toki.Unit.MinuteTest do
  use ExUnit.Case

  test "get" do
    assert Toki.Unit.Minute.get(%Toki.DateTime{minute: 23}) == 23
  end

  test "set" do
    date = Toki.Unit.Minute.set(%Toki.DateTime{minute: 23}, 52)
    assert date == %Toki.DateTime{minute: 52}
  end

  test "add" do
    date = Toki.Unit.Minute.add(%Toki.DateTime{hour: 12, minute: 23}, 6)
    assert date == %Toki.DateTime{hour: 12, minute: 29}
  end

  test "subtract" do
    date = Toki.Unit.Minute.add(%Toki.DateTime{hour: 12, minute: 23}, -89)
    assert date == %Toki.DateTime{hour: 10, minute: 54}
  end

  test "parse_minute" do
    assert Toki.Unit.Minute.parse_minute("23", %Toki.DateTime{}) == %Toki.DateTime{minute: 23}
  end
end
