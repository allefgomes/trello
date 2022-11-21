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

  # def show(conn, %{"id" => id}) do
  #   case Boards.get_board_by_creator!(id, conn.assigns.current_user.id) do
  #     %Board{} = board ->
  #       conn
  #       |> render("show.html", board: board)

  #     _ ->
  #       conn
  #       |> put_flash(:error, "Board not found or you aren't creator.")
  #       |> redirect(to: Routes.board_path(conn, :index))
  #   end
  # end
end
