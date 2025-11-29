defmodule Ponos.Repo do
  use Ecto.Repo,
    otp_app: :ponos,
    adapter: Ecto.Adapters.Postgres
end
