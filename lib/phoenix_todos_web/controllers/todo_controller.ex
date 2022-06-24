defmodule PhoenixTodosWeb.TodoController do
  use PhoenixTodosWeb, :controller

  alias PhoenixTodos.Organize
  alias PhoenixTodos.Organize.Todo

  action_fallback PhoenixTodosWeb.FallbackController

  def index(conn, _params) do
    todos = Organize.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- Organize.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Organize.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Organize.get_todo!(id)

    with {:ok, %Todo{} = todo} <- Organize.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Organize.get_todo!(id)

    with {:ok, %Todo{}} <- Organize.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
