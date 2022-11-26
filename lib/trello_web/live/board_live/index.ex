defmodule TrelloWeb.BoardLive.Index do
  use TrelloWeb, :live_view

  alias Trello.Boards
  alias TrelloWeb.BoardLive.Components.FormComponent

  @impl true
  def mount(_params, session, socket) do
    current_user = Trello.Accounts.get_user_by_session_token(session["user_token"])

    socket =
      socket
      |> assign(user_token: session["user_token"])
      |> assign(current_user: current_user)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(board: %Trello.Boards.Board{})
    |> assign(page_title: "New Board | Trello")
    |> assign(changeset: %Trello.Boards.Board{})
    |> assign(boards_of_user: Boards.list_boards(socket.assigns.current_user.id))
    |> assign(current_user: socket.assigns.current_user)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:boards_of_user, Boards.list_boards(socket.assigns.current_user.id))
    |> assign(:user_token, socket.assigns.user_token)
    |> assign(:page_title, "Trello Boards")
    |> assign(current_user: socket.assigns.current_user)
  end
end
