defmodule Toki.Unit.SecondTest do
  use ExUnit.Case

  test "get" do
    assert Toki.Unit.Second.get(%Toki.DateTime{second: 23}) == 23
  end

  test "set" do
    date = Toki.Unit.Second.set(%Toki.DateTime{second: 23}, 52)
    assert date == %Toki.DateTime{second: 52}
  end

  test "add" do
    date = Toki.Unit.Second.add(%Toki.DateTime{hour: 15, minute: 16, second: 17}, 34)
    assert date == %Toki.DateTime{hour: 15, minute: 16, second: 51}
  end

  test "subtract" do
    date = Toki.Unit.Second.add(%Toki.DateTime{hour: 15, minute: 16, second: 17}, -169)
    assert date == %Toki.DateTime{hour: 15, minute: 13, second: 28}
  end

  test "parse_second" do
    assert Toki.Unit.Second.parse_second("23", %Toki.DateTime{}) == %Toki.DateTime{second: 23}
  end
end
