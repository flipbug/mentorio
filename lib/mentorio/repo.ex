defmodule Mentorio.Repo do
  use Ecto.Repo,
    otp_app: :mentorio,
    adapter: Ecto.Adapters.Postgres
end
