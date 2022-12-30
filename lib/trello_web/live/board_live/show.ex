defmodule TrelloWeb.BoardLive.Show do
  use TrelloWeb, :live_view

  alias Trello.Boards.Board
  alias Phoenix.LiveView.JS

  @impl true
  def mount(%{"board_id" => board_id}, session, socket) do
    current_user = get_current_user(session)

    case Trello.Boards.get_board_by_creator!(board_id, current_user.id) do
      %Board{} = board ->
        {:ok,
         socket
         |> assign(:board, board)
         |> assign(:page_title, board.name <> " | Trello")
         |> assign(:new_card, Trello.Cards.change_card(%Trello.Boards.Card{}))}

      _ ->
        {:ok, redirect(socket, to: "/")}
    end
  end

  @impl true
  def handle_event(
        "dropped",
        %{"draggedId" => card_id, "dropzoneId" => list_id},
        %{assigns: _assigns} = socket
      ) do
    Trello.Cards.get_card!(card_id)
    |> Trello.Cards.update_card(%{list_id: list_id})

    {:noreply, socket}
  end

  @impl true
  def handle_event("save-new-card", %{"card" => card_params}, socket) do
    {:ok, card} =
      card_params
      |> Trello.Cards.create_card()

    card = card |> Trello.Repo.preload(:list)

    {:noreply,
     socket
     |> put_flash(:info, "Card has created!")
     |> push_redirect(to: Routes.board_show_path(socket, :show, card.list.board_id))}
  end

  @impl true
  def handle_event("validate-new-card", %{"card" => card_params}, socket) do
    card = Trello.Cards.new(card_params)

    {:noreply, socket}
  end

  defp get_current_user(session) do
    Trello.Accounts.get_user_by_session_token(session["user_token"])
  end
end
