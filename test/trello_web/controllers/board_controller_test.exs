defmodule TrelloWeb.BoardontrollerTest do
  use TrelloWeb.ConnCase

  import Trello.BoardsFixtures

  setup :register_and_log_in_user

  describe "GET /boards" do
    test "render a page with boards of current user", %{conn: conn} do
      board_fixture()

      conn = get(conn, Routes.board_path(conn, :index))

      assert html_response(conn, 200) =~
               "<h1 class=\"font-bold text-2xl antialiased\">Your Boards</h1>"
    end
  end

  describe "GET /boards/new" do
    test "render a page to create a new board", %{conn: conn} do
      conn = get(conn, Routes.board_path(conn, :new))

      assert html_response(conn, 200) =~
               "<h1 class=\"font-bold text-2xl antialiased\">New Board</h1>"
    end
  end

  describe "POST /boards" do
    test "creates account and logs the user in", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.board_path(conn, :create), %{
          "board" => valid_board_attributes(creator_id: user.id)
        })

      assert redirected_to(conn) == Routes.board_path(conn, :index)

      # Now do a logged in request and assert on the menu
      conn = get(conn, Routes.board_path(conn, :index))
      response = html_response(conn, 200)

      assert response =~ "Your Boards"
    end

    test "render errors for invalid data", %{conn: conn} do
      conn =
        post(conn, Routes.board_path(conn, :create), %{
          "board" => %{
            "name" => "",
            "status" => nil,
            "background" => "",
            "creator_id" => nil
          }
        })

      response = html_response(conn, 200)
      assert response =~ "<h1 class=\"font-bold text-2xl antialiased\">New Board</h1>"
    end
  end
end
