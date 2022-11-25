defmodule TrelloWeb.BoardLive.FormComponentTest do
  use TrelloWeb.ConnCase

  import Phoenix.LiveViewTest
  import Trello.BoardsFixtures

  setup :register_and_log_in_user

  describe "mount/3" do
    test "should load modal to insert a board", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.board_index_path(conn, :index))

      assert view
             |> element("[data-role=add-new-board]", "Create new board")
             |> render_click()
    end
  end

  test "validate data when change a value ", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, Routes.board_index_path(conn, :new))

    assert view
           |> element("form")
           |> render_change(%{background: "#ccc"}) =~
             ~s(<span class=\"text-red-700\" phx-feedback-for=\"board[name]\">can&#39;t be blank</span>)
  end

  test "create new board when data is valid ", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, Routes.board_index_path(conn, :new))

    board_attrs = valid_board_attributes()

    {:ok, view, html} =
      view
      |> form("#new", board: board_attrs)
      |> render_submit()
      |> follow_redirect(conn)

    assert element(view, "#board-title", board_attrs.name)
    assert html =~ "Board has created!"
  end

  test "render errors when data is not valid ", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, Routes.board_index_path(conn, :new))

    invalid_board_attrs = %{background: nil, name: nil}

    assert view
           |> form("#new", board: invalid_board_attrs)
           |> render_submit() =~
             ~s(<span class=\"text-red-700\" phx-feedback-for=\"board[name]\">can&#39;t be blank</span>)
  end
end
