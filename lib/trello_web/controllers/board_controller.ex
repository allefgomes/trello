defmodule TrelloWeb.BoardController do
  use TrelloWeb, :controller

  alias Trello.Boards
  alias Trello.Boards.Board

  def index(conn, _params) do
    render(conn, "index.html", boards_of_user: Boards.list_boards(conn.assigns.current_user.id))
  end

  def new(conn, _params) do
    changeset = Boards.change_board(%Board{active: true})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"board" => board_params}) do
    case Boards.create_board(
           Map.merge(board_params, %{
             "active" => true,
             "creator_id" => conn.assigns.current_user.id
           })
         ) do
      {:ok, _board} ->
        conn
        |> put_flash(:info, "Board created successfully.")
        |> redirect(to: Routes.board_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
