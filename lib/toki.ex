defmodule Toki do
  def parse(value, pattern) do
    Toki.Parser.parse(value, pattern)
  end
end
