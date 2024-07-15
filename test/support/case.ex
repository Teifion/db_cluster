defmodule DBCluster.Case do
  @moduledoc false

  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox
  alias DBCluster.Test.Repo
  alias DBCluster.ClusterMember

  using do
    quote do
      # stream_data library
      # use ExUnitProperties

      import DBCluster.Case

      alias DBCluster.Config
      alias DBCluster.Test.Repo
      alias DBCluster.TestSupport.TestConn
    end
  end

  setup context do
    if context[:unboxed] do
      # Do stuff here
    else
      pid = Sandbox.start_owner!(Repo, shared: not context[:async])

      on_exit(fn -> Sandbox.stop_owner(pid) end)
    end

    :ok
  end

  def node_fixture(hostname \\ nil) do
    ClusterMember.changeset(
      %ClusterMember{},
      %{
        host: hostname || ("host-" <> Ecto.UUID.generate())
      }
    )
    |> DBCluster.Repo.insert!()
  end
end
