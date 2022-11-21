defmodule TrelloWeb.BoardLiveTest do
  use TrelloWeb.ConnCase

  import Phoenix.LiveViewTest
  import Trello.{BoardsFixtures, CardsFixtures, ListsFixtures}

  setup :register_and_log_in_user

  test "should has a div called with id drag-id", %{conn: conn, user: user} do
    board = board_fixture(creator_id: user.id)

    {:ok, view, _html} = live(conn, Routes.board_index_path(conn, :index, board.id))

    assert has_element?(view, "div#drag-id")
  end

  test "should return error if not found board with an uuid and redirect to '/'", %{conn: conn} do
    assert {:error, {:redirect, %{to: "/"}}} =
             live(conn, Routes.board_index_path(conn, :index, Ecto.UUID.generate()))
  end

  test "handle_event/3 dropped", %{conn: conn, user: user} do
    board = board_fixture(creator_id: user.id)

    {:ok, view, _html} = live(conn, Routes.board_index_path(conn, :index, board.id))

    [todo, production] = [
      list_fixture(board_id: board.id, title: "Todo"),
      list_fixture(board_id: board.id, title: "Production")
    ]

    card = card_fixture(list_id: todo.id)

    assert render_hook(view, :dropped, %{
             "draggedId" => card.id,
             "dropzoneId" => production.id
           })
  end
end
