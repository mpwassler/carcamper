defmodule SwStore.Repo do
  use Ecto.Repo,
    otp_app: :sw_store,
    adapter: Ecto.Adapters.Postgres
end
