defmodule PhoenixTodos.OrganizeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixTodos.Organize` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        is_completed: true,
        name: "some name"
      })
      |> PhoenixTodos.Organize.create_todo()

    todo
  end
end
