# DBCluster
A library to use the database for defining your cluster where each node is able to access the same table. Nodes can be dynamically added as long as they add the relevant entry to the table.

## Installation
```elixir
def deps do
  [
    {:db_cluster, "~> 0.0.1"}
  ]
end
```

Now add a migration
```bash
mix ecto.gen.migration add_db_cluster_tables
```

Open the generated migration and add the below code:
```elixir
defmodule MyApp.Repo.Migrations.AddDBClusterTables do
  use Ecto.Migration

  def up do
    DBCluster.Migration.up()
  end

  # We specify `version: 1` in `down`, ensuring that we'll roll all the way back down if
  # necessary, regardless of which version we've migrated `up` to.
  def down do
    DBCluster.Migration.down(version: 1)
  end
end
```

Finally, update your config to link the repo:
```
config :db_cluster,
  repo: MyApp.Repo
```
