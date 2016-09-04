defmodule Toki.Unit do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :patterns, accumulate: true)
      @before_compile Toki.Unit
    end
  end

  defmacro pattern(token, pattern) do
    quote do
      @patterns {unquote(token), unquote(pattern)}
    end
  end

  defmacro __before_compile__(env) do
    patterns = Module.get_attribute(env.module, :patterns)
    |> compile_patterns
    |> Macro.escape

    quote do
      defmacro __using__(_) do
        unquote(patterns)
      end
    end
  end

  defp compile_patterns(patterns) do
    Enum.map(patterns, fn {token, pattern} ->
      quote do
        defp do_compile(unquote(token) <> rest, acc) do
          do_compile(rest, acc <> "(?<#{unquote token}>#{unquote pattern})")
        end
      end
    end)
  end
end
