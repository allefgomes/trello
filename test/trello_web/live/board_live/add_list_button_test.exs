defmodule TrelloWeb.BoardLive.Components.AddListButtonTest do
  use TrelloWeb.ConnCase

  import Phoenix.LiveViewTest
  import Trello.BoardsFixtures

  setup :register_and_log_in_user

  describe "mount/3" do
    test "should show a input to insert a list", %{conn: conn, user: user} do
      board = board_fixture(creator_id: user.id)
      {:ok, view, _html} = live(conn, Routes.board_show_path(conn, :show, board.id))

      assert view
             |> element("#add-new-list-button", "Add another list")
             |> has_element?()

      assert view
             |> element("#add-new-list-form")
             |> render() =~ "display: none;"
    end
  end
end
