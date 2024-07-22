defmodule DBCluster do
  @moduledoc """
  DBCluster provides a database backed method of clustering your nodes. At startup, each node will query the database for other nodes and try to connect to them (while adding themselves to the database). In this manner you can add new nodes without having to update lists or use things like kubernetes.

  Aside from the initial setup it is not expected you will need to interface with the DBCluster app, the majority of functions exported are related to querying the database table used by the app.

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

  ## Configs
  You may find the cluster server launching causes issues in tests, you can disable it via
  config with:
  ```
  config :db_cluster,
    enabled: false
  ```

  ### Post join functions
  You can optionally set one or more functions to be called when a cluster join takes place as per the below config option.
  ```
  config :db_cluster,
    db_cluster_post_join_functions: [&func1/0, &func2/0]
  ```
  """


  alias DBCluster.{ClusterMemberLib, ClusterMemberQueries}

  @doc false
  @spec cluster_member_query(list()) :: Ecto.Query.t()
  defdelegate cluster_member_query(args), to: ClusterMemberQueries

  @doc section: :cluster_member
  @spec list_cluster_members(list) :: [ClusterMember.t()]
  defdelegate list_cluster_members(args), to: ClusterMemberLib

  @doc section: :cluster_member
  @spec get_cluster_member!(Teiserver.cluster_member_id()) :: ClusterMember.t()
  defdelegate get_cluster_member!(cluster_member_id), to: ClusterMemberLib

  @doc section: :cluster_member
  @spec get_cluster_member(Teiserver.cluster_member_id()) :: ClusterMember.t() | nil
  defdelegate get_cluster_member(cluster_member_id), to: ClusterMemberLib

  @doc section: :cluster_member
  @spec create_cluster_member(map) :: {:ok, ClusterMember.t()} | {:error, Ecto.Changeset.t()}
  defdelegate create_cluster_member(attrs \\ %{}), to: ClusterMemberLib

  @doc section: :cluster_member
  @spec update_cluster_member(ClusterMember, map) :: {:ok, ClusterMember.t()} | {:error, Ecto.Changeset.t()}
  defdelegate update_cluster_member(cluster_member, attrs), to: ClusterMemberLib

  @doc section: :cluster_member
  @spec delete_cluster_member(ClusterMember.t()) :: {:ok, ClusterMember.t()} | {:error, Ecto.Changeset.t()}
  defdelegate delete_cluster_member(cluster_member), to: ClusterMemberLib

  @doc section: :cluster_member
  @spec change_cluster_member(ClusterMember.t(), map) :: Ecto.Changeset.t()
  defdelegate change_cluster_member(cluster_member, attrs \\ %{}), to: ClusterMemberLib
end
