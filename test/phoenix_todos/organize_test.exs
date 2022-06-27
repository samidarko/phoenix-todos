defmodule PhoenixTodos.OrganizeTest do
  use PhoenixTodos.DataCase

  alias PhoenixTodos.Organize

  describe "todos" do
    alias PhoenixTodos.Organize.Todo

    import PhoenixTodos.OrganizeFixtures

    @invalid_attrs %{is_completed: nil, name: nil}

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Organize.list_todos() == [todo]
    end

    test "toggle_todo/1 returns the todo is_completed toggled" do
      todo = todo_fixture()
      assert {:ok, %Todo{} = toggled_todo} = Organize.toggle_todo(todo)
      assert toggled_todo.is_completed == not todo.is_completed
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Organize.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      valid_attrs = %{is_completed: true, name: "some name"}

      assert {:ok, %Todo{} = todo} = Organize.create_todo(valid_attrs)
      assert todo.is_completed == false
      assert todo.name == "some name"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organize.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      update_attrs = %{is_completed: false, name: "some updated name"}

      assert {:ok, %Todo{} = todo} = Organize.update_todo(todo, update_attrs)
      assert todo.is_completed == false
      assert todo.name == "some updated name"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Organize.update_todo(todo, @invalid_attrs)
      assert todo == Organize.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Organize.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Organize.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Organize.change_todo(todo)
    end
  end
end
