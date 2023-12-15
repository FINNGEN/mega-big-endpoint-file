defmodule EndpointDB.Repo do
  use Ecto.Repo,
    otp_app: :endpoint_db,
    adapter: Ecto.Adapters.Postgres
end
