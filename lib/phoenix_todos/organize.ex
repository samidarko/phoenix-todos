defmodule PhoenixTodos.Organize do
  @moduledoc """
  The Organize context.
  """

  import Ecto.Query, warn: false
  alias PhoenixTodos.Repo

  alias PhoenixTodos.Organize.Todo

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Todo{}, ...]

  """
  def list_todos(opts \\ []) do
    Todo
    |> todos_query_with_is_completed(opts[:is_completed])
    |> Repo.all()
  end

  defp todos_query_with_is_completed(query, is_completed) when is_boolean(is_completed) do
    from(q in query, where: q.is_completed == ^is_completed)
  end

  defp todos_query_with_is_completed(query, "true") do
    todos_query_with_is_completed(query, true)
  end

  defp todos_query_with_is_completed(query, "false") do
    todos_query_with_is_completed(query, false)
  end

  defp todos_query_with_is_completed(query, _), do: query

  @doc """
  Gets a single todo.

  Raises `Ecto.NoResultsError` if the Todo does not exist.

  ## Examples

      iex> get_todo!(123)
      %Todo{}

      iex> get_todo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo!(id), do: Repo.get!(Todo, id)

  @doc """
  Creates a todo.

  ## Examples

      iex> create_todo(%{field: value})
      {:ok, %Todo{}}

      iex> create_todo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo(attrs \\ %{}) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a todo.

  ## Examples

      iex> update_todo(todo, %{field: new_value})
      {:ok, %Todo{}}

      iex> update_todo(todo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo.

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo(%Todo{} = todo) do
    Repo.delete(todo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo changes.

  ## Examples

      iex> change_todo(todo)
      %Ecto.Changeset{data: %Todo{}}

  """
  def change_todo(%Todo{} = todo, attrs \\ %{}) do
    Todo.changeset(todo, attrs)
  end

  def toggle_todo(%Todo{is_completed: is_completed} = todo) do
    todo
    |> Todo.toggle_changeset(%{is_completed: not is_completed})
    |> Repo.update()
  end
end
