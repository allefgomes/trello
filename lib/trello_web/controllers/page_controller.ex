defmodule TrelloWeb.PageController do
  use TrelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
