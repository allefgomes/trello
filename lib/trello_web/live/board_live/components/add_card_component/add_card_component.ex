defmodule TrelloWeb.BoardLive.Components.AddCardComponent do
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
end
