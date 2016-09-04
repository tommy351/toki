defmodule Toki.Unit do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :patterns, accumulate: true)
      Module.register_attribute(__MODULE__, :parsers, accumulate: true)

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro pattern(token, pattern) do
    quote do
      @patterns {unquote(token), unquote(pattern)}
    end
  end

  defmacro parse(token, parser) do
    quote do
      @parsers {unquote(token), unquote(Macro.escape(parser))}
    end
  end

  defmacro __before_compile__(env) do
    patterns = Module.get_attribute(env.module, :patterns)
    |> compile_patterns
    |> Macro.escape

    parsers = Module.get_attribute(env.module, :parsers)
    |> compile_parsers
    |> Macro.escape

    quote do
      defmacro __using__(:compile) do
        unquote(patterns)
      end

      defmacro __using__(:parse) do
        unquote(parsers)
      end

      defmacro __using__(_) do
        quote do
          use unquote(__MODULE__), :compile
          use unquote(__MODULE__), :parse
        end
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

  defp compile_parsers(parsers) do
    Enum.map(parsers, fn {token, parser} ->
      quote do
        defp do_parse([{unquote(token), value} | rest], acc) do
          unquote(parser).(value, acc)
        end
      end
    end)
  end
end
