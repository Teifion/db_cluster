import Config

config :logger, level: :warning

config :db_cluster, DBCluster.Test.Repo,
  migration_lock: false,
  name: DBCluster.Test.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  priv: "test/support/postgres",
  url:
    System.get_env("DATABASE_URL") ||
      "postgres://db_cluster_test:postgres@localhost/db_cluster_test"

config :db_cluster,
  # Used for tests
  ecto_repos: [DBCluster.Test.Repo]

# Import environment specific config
try do
  import_config "#{config_env()}.exs"
rescue
  _ in File.Error ->
    nil

  error ->
    reraise error, __STACKTRACE__
end
