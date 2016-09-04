defmodule Toki.Unit.Year do
  use Toki.Unit

  pattern "YYYY","\\d{1,4}"

  parse "YYYY", fn (value, date) ->
    {int, ""} = Integer.parse(value)
    %{date | year: int}
  end
end
