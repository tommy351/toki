defmodule Toki.DateTimeTest do
  use ExUnit.Case

  @datetime %Toki.DateTime{
    year: 2015,
    month: 6,
    day: 7,
    hour: 15,
    minute: 16,
    second: 17
  }

  test "from_erlang_date" do
    assert Toki.DateTime.from_erlang_date({2015, 6, 7}) == %Toki.DateTime{year: 2015, month: 6, day: 7}
  end

  test "from_erlang_time" do
    assert Toki.DateTime.from_erlang_time({15, 16, 17}) == %Toki.DateTime{hour: 15, minute: 16, second: 17}
  end

  test "from_erlang_datetime" do
    assert Toki.DateTime.from_erlang_datetime({{2015, 6, 7}, {15, 16, 17}}) == %Toki.DateTime{year: 2015, month: 6, day: 7, hour: 15, minute: 16, second: 17}
  end

  test "to_erlang_date" do
    assert Toki.DateTime.to_erlang_date(@datetime) == {2015, 6, 7}
  end

  test "to_erlang_time" do
    assert Toki.DateTime.to_erlang_time(@datetime) == {15, 16, 17}
  end

  test "to_erlang_datetime" do
    assert Toki.DateTime.to_erlang_datetime(@datetime) == {{2015, 6, 7}, {15, 16, 17}}
  end
end
