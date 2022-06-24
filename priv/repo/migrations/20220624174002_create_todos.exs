defmodule PhoenixTodos.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :is_completed, :boolean, default: false, null: false

      timestamps()
    end
  end
end
