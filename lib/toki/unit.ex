defmodule Toki.Unit do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :patterns, accumulate: true)
      Module.register_attribute(__MODULE__, :parsers, accumulate: true)
      Module.register_attribute(__MODULE__, :formatters, accumulate: true)

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro pattern(token, pattern) do
    quote location: :keep do
      @patterns {unquote(token), unquote(pattern)}
    end
  end

  defmacro parse(token, parser) do
    quote location: :keep do
      @parsers {unquote(token), unquote(Macro.escape(parser))}
    end
  end

  defmacro format(token, format, formatter) do
    quote location: :keep do
      @formatters {unquote(token), unquote(format), unquote(Macro.escape(formatter))}
    end
  end

  defmacro __before_compile__(env) do
    patterns = Module.get_attribute(env.module, :patterns)
    |> compile_patterns
    |> Macro.escape

    parsers = Module.get_attribute(env.module, :parsers)
    |> compile_parsers
    |> Macro.escape

    formatters = Module.get_attribute(env.module, :formatters)
    |> compile_formatters
    |> Macro.escape

    quote do
      defmacro __using__(:compile) do
        unquote(patterns)
      end

      defmacro __using__(:parse) do
        unquote(parsers)
      end

      defmacro __using__(:format) do
        unquote(formatters)
      end
    end
  end

  defp compile_patterns(patterns) do
    Enum.reverse(patterns)
    |> Enum.map(fn {token, pattern} ->
      quote do
        defp do_compile(unquote(token) <> rest, acc) do
          do_compile(rest, acc <> "(?<#{unquote token}>#{unquote pattern})")
        end
      end
    end)
  end

  defp compile_parsers(parsers) do
    Enum.reverse(parsers)
    |> Enum.map(fn {token, parser} ->
      quote do
        defp do_parse([{unquote(token), value} | rest], acc) do
          unquote(parser).(value, acc)
        end
      end
    end)
  end

  defp compile_formatters(formatters) do
    Enum.reverse(formatters)
    |> Enum.map(fn {token, format, formatter} ->
      quote do
        defp do_format(unquote(token) <> rest, date, acc, values) do
          value = unquote(formatter).(date)
          do_format(rest, date, acc <> unquote(format), [value | values])
        end
      end
    end)
  end
end
