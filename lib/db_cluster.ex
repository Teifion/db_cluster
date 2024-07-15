defmodule DBCluster do
  @moduledoc false
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
