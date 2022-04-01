defmodule EConcurrency.MixProject do
  use Mix.Project

  def project do
    [
      app: :e_concurrency,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {EConcurrency.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.2.1"},
      {:plug_cowboy, "~> 2.0"},
      {:benchee, "~> 1.0", only: :dev},
      {:mimic, "~> 1.7", only: :test}
    ]
  end
end
