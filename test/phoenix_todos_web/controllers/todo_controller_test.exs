defmodule PhoenixTodosWeb.TodoControllerTest do
  use PhoenixTodosWeb.ConnCase

  import PhoenixTodos.OrganizeFixtures

  alias PhoenixTodos.Organize.Todo

  @create_attrs %{
    is_completed: true,
    name: "some name"
  }
  @update_attrs %{
    is_completed: false,
    name: "some updated name"
  }
  @invalid_attrs %{is_completed: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all todos", %{conn: conn} do
      conn = get(conn, Routes.todo_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create todo" do
    test "renders todo when data is valid", %{conn: conn} do
      conn = post(conn, Routes.todo_path(conn, :create), todo: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.todo_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "is_completed" => false,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.todo_path(conn, :create), todo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update todo" do
    setup [:create_todo]

    test "renders todo when data is valid", %{conn: conn, todo: %Todo{id: id} = todo} do
      conn = put(conn, Routes.todo_path(conn, :update, todo), todo: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.todo_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "is_completed" => false,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, todo: todo} do
      conn = put(conn, Routes.todo_path(conn, :update, todo), todo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete todo" do
    setup [:create_todo]

    test "deletes chosen todo", %{conn: conn, todo: todo} do
      conn = delete(conn, Routes.todo_path(conn, :delete, todo))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.todo_path(conn, :show, todo))
      end
    end
  end

  describe "toggle todo" do
    setup [:create_todo]

    test "renders toggled todo", %{
      conn: conn,
      todo: %Todo{id: id, is_completed: is_completed} = todo
    } do
      conn = put(conn, Routes.todo_todo_path(conn, :toggle, todo))
      toggled_is_completed = not is_completed

      assert %{
               "id" => ^id,
               "is_completed" => ^toggled_is_completed,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end
  end

  defp create_todo(_) do
    todo = todo_fixture()
    %{todo: todo}
  end
end
