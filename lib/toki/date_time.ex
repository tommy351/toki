defmodule Toki.DateTime do
  defstruct year: 1,
            month: 1,
            day: 1,
            hour: 0,
            minute: 0,
            second: 0,
            nanosecond: 0

  @type year :: integer
  @type month :: 1..12
  @type day :: 1..31
  @type hour :: 0..23
  @type minute :: 0..59
  @type second :: 0..59
  @type nanosecond :: 0..999_999_999

  @type date :: {year, month, day}
  @type time :: {hour, minute, second}
  @type datetime :: {date, time}
  @type timestamp :: {megasec :: pos_integer, sec :: pos_integer, microsec :: pos_integer}

  @type t :: %__MODULE__{
    year: integer,
    month: month,
    day: day,
    hour: hour,
    minute: minute,
    second: second,
    nanosecond: nanosecond
  }

  @units year: Toki.Unit.Year,
         month: Toki.Unit.Month,
         day: Toki.Unit.Day,
         hour: Toki.Unit.Hour,
         minute: Toki.Unit.Minute,
         second: Toki.Unit.Second

  for {key, module} <- @units do
    def unquote(:"get_#{key}")(date), do: unquote(module).get(date)
    def unquote(:"set_#{key}")(date, value), do: unquote(module).set(date, value)
    def unquote(:"add_#{key}")(date, value), do: unquote(module).add(date, value)
    def unquote(:"subtract_#{key}")(date, value), do: unquote(:"add_#{key}")(date, -value)
  end

  @spec format(t, String.t) :: String.t
  def format(date, pattern) do
    Toki.Formatter.format(date, pattern)
  end

  @spec from_erlang_date(date) :: t
  def from_erlang_date({year, month, day}) do
    %__MODULE__{
      year: year,
      month: month,
      day: day
    }
  end

  @spec from_erlang_time(time) :: t
  def from_erlang_time({hour, minute, second}) do
    %__MODULE__{
      hour: hour,
      minute: minute,
      second: second
    }
  end

  @spec from_erlang_datetime(datetime) :: t
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

  @spec from_erlang_timestamp(timestamp) :: t
  def from_erlang_timestamp({_, _, us} = value) do
    date = :calendar.now_to_universal_time(value) |> from_erlang_datetime
    %{date | nanosecond: us * 1000}
  end

  @spec to_erlang_date(t) :: date
  def to_erlang_date(date) do
    {get_year(date), get_month(date), get_day(date)}
  end

  @spec to_erlang_time(t) :: time
  def to_erlang_time(date) do
    {get_hour(date), get_minute(date), get_second(date)}
  end

  @spec to_erlang_datetime(t) :: datetime
  def to_erlang_datetime(date) do
    {to_erlang_date(date), to_erlang_time(date)}
  end
end
