defmodule PhoenixTodos.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_todos,
    adapter: Ecto.Adapters.Postgres
end
