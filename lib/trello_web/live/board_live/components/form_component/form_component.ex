defmodule TrelloWeb.BoardLive.Components.FormComponent do
  use TrelloWeb, :live_component

  alias Trello.Boards.Board

  def update(assigns, socket) do
    changeset = Trello.Boards.change_board(%Board{})
    boards_of_user = Trello.Boards.list_boards(assigns.current_user.id)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> assign(boards_of_user: boards_of_user)
     |> assign(board: %Board{})}
  end

  def handle_event("validate", %{"board" => board_params}, socket) do
    changeset =
      socket.assigns.board
      |> Trello.Boards.change_board(board_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"board" => board_params}, socket) do
    case Trello.Boards.create_board(
           Map.merge(board_params, %{"creator_id" => socket.assigns.current_user.id})
         ) do
      {:ok, board} ->
        {:noreply,
         socket
         |> put_flash(:info, "Board has created!")
         |> push_redirect(to: Routes.board_show_path(socket, :show, board.id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
