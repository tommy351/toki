defmodule Toki.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @github_link "https://github.com/tommy351/toki"

  def project do
    [app: :toki,
     version: @version,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: preferred_cli_env(),
     docs: [main: "Toki",
            source_ref: @version,
            source_url: @github_link]]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [{:ex_doc, "~> 0.12", only: :docs},
     {:excoveralls, "~> 0.5", only: :test},
     {:inch_ex, "~> 0.5", only: :docs}]
  end

  defp package do
    [maintainers: ["Tommy Chen"],
     licenses: ["MIT License"],
     links: %{"GitHub" => @github_link}]
  end

  defp preferred_cli_env do
    ["coveralls": :test,
     "coveralls.travis": :test,
     "docs": :docs,
     "hex.docs": :docs,
     "inchci.add": :docs,
     "inchci.report": :docs]
  end
end
