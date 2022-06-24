defmodule PhoenixTodosWeb.PageController do
  use PhoenixTodosWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
