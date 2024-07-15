defmodule DBCluster.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DBCluster.ClusterManagerSupervisor,
    ]

    opts = [strategy: :one_for_one, name: DBCluster.Supervisor]
    result = Supervisor.start_link(children, opts)

    DBCluster.ClusterManagerSupervisor.start_cluster_manager_supervisor_children()
    result
  end
end
