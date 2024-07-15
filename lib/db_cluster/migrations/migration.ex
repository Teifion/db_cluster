defmodule DBCluster.Migrations do
  @moduledoc false
  # Credit to the Oban library for their superb migration code

  defdelegate up(opts \\ []), to: DBCluster.Migration
  defdelegate down(opts \\ []), to: DBCluster.Migration
end

defmodule DBCluster.Migration do
  @moduledoc false

  use Ecto.Migration

  @doc """
  Migrates storage up to the latest version.
  """
  @callback up(Keyword.t()) :: :ok

  @doc """
  Migrates storage down to the previous version.
  """
  @callback down(Keyword.t()) :: :ok

  @doc """
  Identifies the last migrated version.
  """
  @callback migrated_version(Keyword.t()) :: non_neg_integer()

  @doc """
  Run the `up` changes for all migrations between the initial version and the current version.

  ## Example

  Run all migrations up to the current version:

      DBCluster.Migration.up()

  Run migrations up to a specified version:

      DBCluster.Migration.up(version: 2)

  Run migrations in an alternate prefix:

      DBCluster.Migration.up(prefix: "game_server")

  Run migrations in an alternate prefix but don't try to create the schema:

      DBCluster.Migration.up(prefix: "game_server", create_schema: false)
  """
  def up(opts \\ []) when is_list(opts) do
    migrator().up(opts)
  end

  @doc """
  Run the `down` changes for all migrations between the current version and the initial version.

  ## Example

  Run all migrations from current version down to the first:

      DBCluster.Migration.down()

  Run migrations down to and including a specified version:

      DBCluster.Migration.down(version: 5)

  Run migrations in an alternate prefix:

      DBCluster.Migration.down(prefix: "game_server")
  """
  def down(opts \\ []) when is_list(opts) do
    migrator().down(opts)
  end

  @doc """
  Check the latest version the database is migrated to.

  ## Example

      DBCluster.Migration.migrated_version()
  """
  def migrated_version(opts \\ []) when is_list(opts) do
    migrator().migrated_version(opts)
  end

  defp migrator do
    case repo().__adapter__() do
      Ecto.Adapters.Postgres -> DBCluster.Migrations.Postgres
      _ -> Keyword.fetch!(repo().config(), :migrator)
    end
  end
end
