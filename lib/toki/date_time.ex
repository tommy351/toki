defmodule Toki.DateTime do
  defstruct year: 1,
            month: 1,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0,
            nanosecond: 0

  @units year: Toki.Unit.Year,
         month: Toki.Unit.Month,
         day: Toki.Unit.Day,
         hour: Toki.Unit.Hour,
         minute: Toki.Unit.Minute,
         second: Toki.Unit.Second

  for {key, module} <- @units do
    def unquote(:"get_#{key}")(date), do: unquote(module).get(date)
    def unquote(:"set_#{key}")(date, value), do: unquote(module).set(date, value)
  end

  def format(date, pattern) do
    Toki.Formatter.format(date, pattern)
  end

  def from_erlang_date({year, month, day}) do
    %__MODULE__{
      year: year,
      month: month,
      day: day
    }
  end

  def from_erlang_time({hour, minute, second}) do
    %__MODULE__{
      hour: hour,
      minute: minute,
      second: second
    }
  end

  def from_erlang_datetime({{year, month, day}, {hour, minute, second}}) do
    %__MODULE__{
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second
    }
  end
end
