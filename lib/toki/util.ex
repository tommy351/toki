defmodule Toki.Util do
  @moduledoc false
  # http://alcor.concordia.ca/~gpkatch/gdate-algorithm.html

  def day_number(y, m, d) do
    m = rem(m + 9, 12)
    y = y - div(m, 10)

    365 * y + div(y, 4) - div(y, 100) + div(y, 400) + div(m * 306 + 5, 10) + (d - 1)
  end

  def date(g) do
    y = div(10000 * g + 14780, 3652425)
    ddd = g - (365 * y + div(y, 4) - div(y, 100) + div(y, 400))

    {y, ddd} = if ddd < 0 do
      y = y - 1
      ddd = g - (365 * y + div(y, 4) - div(y, 100) + div(y, 400))
    else
      {y, ddd}
    end

    mi = div(100 * ddd + 52, 3060)
    mm = rem(mi + 2, 12) + 1
    y = y + div(mi + 2, 12)
    dd = ddd - div(mi * 306 + 5, 10) + 1

    {y, mm, dd}
  end

  def positive_rem(left, right) do
    case {div(left, right), rem(left, right)} do
      {quotient, remainder} when remainder < 0 -> {quotient - 1, remainder + right}
      value -> value 
    end
  end
end
