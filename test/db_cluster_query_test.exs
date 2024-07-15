defmodule DBClusterQueryTest do
  use DBCluster.Case, async: true

  describe "cluster_members" do
    alias DBCluster.ClusterMember

    @valid_attrs %{
      host: "some host"
    }
    @update_attrs %{
      host: "some updated host"
    }
    @invalid_attrs %{
      host: nil
    }

    test "cluster_member_query/0 returns a query" do
      q = DBCluster.cluster_member_query([])
      assert %Ecto.Query{} = q
    end

    test "list_cluster_members/0 returns cluster_members" do
      # No cluster_members yet
      assert DBCluster.list_cluster_members([]) == []

      # Add a cluster_member
      node_fixture()
      assert DBCluster.list_cluster_members([]) != []
    end

    test "get_cluster_member!/1 and get_cluster_member/1 returns the cluster_member with given id" do
      cluster_member = node_fixture()
      assert DBCluster.get_cluster_member!(cluster_member.id) == cluster_member
      assert DBCluster.get_cluster_member(cluster_member.id) == cluster_member
    end

    test "create_cluster_member/1 with valid data creates a cluster_member" do
      assert {:ok, %ClusterMember{} = cluster_member} = DBCluster.create_cluster_member(@valid_attrs)
      assert cluster_member.host == "some host"
    end

    test "create_cluster_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DBCluster.create_cluster_member(@invalid_attrs)
    end

    test "update_cluster_member/2 with valid data updates the cluster_member" do
      cluster_member = node_fixture()
      assert {:ok, %ClusterMember{} = cluster_member} = DBCluster.update_cluster_member(cluster_member, @update_attrs)
      assert cluster_member.host == "some updated host"
    end

    test "update_cluster_member/2 with invalid data returns error changeset" do
      cluster_member = node_fixture()
      assert {:error, %Ecto.Changeset{}} = DBCluster.update_cluster_member(cluster_member, @invalid_attrs)
      assert cluster_member == DBCluster.get_cluster_member!(cluster_member.id)
    end

    test "delete_cluster_member/1 deletes the cluster_member" do
      cluster_member = node_fixture()
      assert {:ok, %ClusterMember{}} = DBCluster.delete_cluster_member(cluster_member)
      assert_raise Ecto.NoResultsError, fn -> DBCluster.get_cluster_member!(cluster_member.id) end
      assert DBCluster.get_cluster_member(cluster_member.id) == nil
    end

    test "change_cluster_member/1 returns a cluster_member changeset" do
      cluster_member = node_fixture()
      assert %Ecto.Changeset{} = DBCluster.change_cluster_member(cluster_member)
    end
  end
end
