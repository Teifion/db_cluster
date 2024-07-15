defmodule DBCluster.Migrations.Postgres.V01 do
  @moduledoc false
  # Copied and tweaked from Oban

  use Ecto.Migration

  @spec up(map) :: any
  def up(%{create_schema: create?, prefix: prefix} = opts) do
    %{escaped_prefix: _escaped, quoted_prefix: quoted} = opts
    if create?, do: execute("CREATE SCHEMA IF NOT EXISTS #{quoted};")

    # Clustering
    create_if_not_exists table(:db_cluster_members, primary_key: false, prefix: prefix) do
      add(:id, :uuid, primary_key: true, null: false)
      add(:host, :string, null: false)

      timestamps(type: :utc_datetime)
    end
  end

  @spec down(map) :: any
  def down(%{prefix: prefix, quoted_prefix: _quoted}) do
    # Comms
    drop_if_exists(table(:db_cluster_members, prefix: prefix))
  end
end
