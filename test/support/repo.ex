defmodule DBCluster.Test.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :db_cluster,
    adapter: Ecto.Adapters.Postgres
end
