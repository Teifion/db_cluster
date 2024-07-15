defmodule DBCluster.Test.Repo.Postgres.Migrations.AddDBClusterTables do
  @moduledoc false
  use Ecto.Migration

  defdelegate up, to: DBCluster.Migrations

  def down do
    DBCluster.Migrations.down(version: 1)
  end
end
