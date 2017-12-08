defmodule AOC.Mixfile do
  use Mix.Project

  def project do
    [
      app: :aoc,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:mex],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:apex, "~> 1.2.0"},
      {:libgraph, "~> 0.11.1"},
      {:mex, "~> 0.0.5", only: [:dev, :test]}
    ]
  end
end
