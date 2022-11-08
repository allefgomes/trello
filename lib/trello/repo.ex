defmodule Trello.Repo do
  use Ecto.Repo,
    otp_app: :trello,
    adapter: Ecto.Adapters.Postgres
end
