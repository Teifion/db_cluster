defmodule DBCluster.MixProject do
  use Mix.Project

  @source_url "https://github.com/Teifion/db_cluster"
  @version "0.0.2"

  def project do
    [
      app: :db_cluster,
      version: @version,
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: [
        "test.ci": :test,
        "test.reset": :test,
        "test.setup": :test
      ],

      # Hex
      description: "Cluster Elixir applications via a database table.",
      package: package(),

      # Docs
      name: "DB Cluster",
      docs: [
        main: "DBCluster",
        api_reference: false,
        source_ref: "v#{@version}",
        source_url: @source_url,
        skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DBCluster.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_env), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, ">= 3.0.0"},
      {:postgrex, ">= 0.0.0"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Teifion Jordan"],
      licenses: ["Apache-2.0"],
      files: ~w(lib .formatter.exs mix.exs README* CHANGELOG* LICENSE*),
      links: %{
        "Changelog" => "#{@source_url}/blob/main/CHANGELOG.md",
        "GitHub" => @source_url
      }
    ]
  end

  defp aliases do
    [
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      # Oban has these and seems to do a really nice job so we're going to use them too
      release: [
        "cmd git tag v#{@version}",
        "cmd git push",
        "cmd git push --tags",
        "hex.publish --yes"
      ],
      "test.reset": ["ecto.drop --quiet", "test.setup"],
      "test.setup": ["ecto.create --quiet", "ecto.migrate --quiet"],
      "test.ci": [
        "format --check-formatted",
        "deps.unlock --check-unused",
        "test --raise"
      ]
    ]
  end
end
