defmodule TrelloWeb.BoardLive.Index do
  use TrelloWeb, :live_view

  alias Trello.Boards.Board

  @impl true
  def mount(%{"board_id" => board_id}, session, socket) do
    current_user = get_current_user(session)

    case Trello.Boards.get_board_by_creator!(board_id, current_user.id) do
      %Board{} = board ->
        {:ok, assign(socket, :board, board)}

      _ ->
        {:ok, redirect(socket, to: "/")}
    end
  end

  @impl true
  def handle_event(
        "dropped",
        %{"draggedId" => draggedId, "dropzoneId" => dropzoneId},
        %{assigns: _assigns} = socket
      ) do
    Trello.Cards.get_card!(draggedId)
    |> Trello.Cards.update_card(%{list_id: dropzoneId})

    {:noreply, socket}
  end

  defp get_current_user(session) do
    Trello.Accounts.get_user_by_session_token(session["user_token"])
  end
end
