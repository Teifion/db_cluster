import Config

config :db_cluster, DBCluster.Test.Repo,
  database: "db_cluster_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :db_cluster,
  repo: DBCluster.Test.Repo
