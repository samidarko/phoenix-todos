defmodule PhoenixTodos.Organize.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "todos" do
    field :is_completed, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  @doc false
  def toggle_changeset(todo, attrs) do
    todo
    |> cast(attrs, [:is_completed])
    |> validate_required([:is_completed])
  end
end
