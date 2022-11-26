defmodule TrelloWeb.BoardLive.Components.AddListButton do
  use TrelloWeb, :live_component

  alias Phoenix.LiveView.JS
  alias Trello.Boards.List

  @impl true
  def update(assigns, socket) do
    changeset = Trello.Lists.change_list(%List{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: changeset)
     |> assign(list: %List{})}
  end

  @impl true
  def handle_event("validate-new-list", %{ "list" => list_params }, socket) do
    changeset =
      socket.assigns.list
      |> Trello.Lists.change_list(Map.merge(list_params, %{"board_id" => socket.assigns.board.id}))
      |> Map.put(:action, :validate)

    {:noreply,
      socket
      |> assign(changeset: changeset)}
  end

  @impl true
  def handle_event("save-new-list", %{"list" => list_params}, socket) do
    case Trello.Lists.create_list(Map.merge(list_params, %{"board_id" => socket.assigns.board.id})) do
      {:ok, list} ->
        {:noreply,
         socket
         |> put_flash(:info, "List has created!")
         |> push_redirect(to: Routes.board_show_path(socket, :show, list.board_id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
