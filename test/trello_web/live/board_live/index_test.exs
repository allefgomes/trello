defmodule TrelloWeb.BoardLive.IndexTest do
  use TrelloWeb.ConnCase

  import Phoenix.LiveViewTest
  import Trello.BoardsFixtures

  describe "mount/3" do
    setup :register_and_log_in_user

    test "given a product when submit the form then return a message that created the product", %{
      conn: conn
    } do
      {:ok, view, _html} = live(conn, Routes.board_index_path(conn, :index))

      open_modal(view)

      board_attrs = valid_board_attributes()

      {:ok, view, html} =
        view
        |> form("#new", board: board_attrs)
        |> render_submit()
        |> follow_redirect(conn)

      assert element(view, "#board-title", board_attrs.name)
      assert html =~ "Board has created!"
    end
  end

  defp open_modal(view) do
    view
    |> element("[data-role=add-new-board]", "Create new board")
    |> render_click()
  end
end
