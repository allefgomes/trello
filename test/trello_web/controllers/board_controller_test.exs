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
    test "create a new board when send valid data", %{conn: conn, user: user} do
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
            "name" => nil,
            "status" => nil,
            "background" => nil,
            "creator_id" => nil
          }
        })

      response = html_response(conn, 200)
      assert response =~ "<h1 class=\"font-bold text-2xl antialiased\">New Board</h1>"
    end
  end

  # describe "GET /boards/:id" do
  #   test "render a page to show a board with specified id", %{conn: conn, user: user} do
  #     board = board_fixture(creator_id: user.id)

  #     conn = get(conn, Routes.board_path(conn, :show, board.id))

  #     assert html_response(conn, 200) =~
  #              "<h1 class=\"font-bold text-2xl antialiased\">#{board.name}</h1>"
  #   end

  #   test "redirect to :index when board not was created from current_user", %{conn: conn} do
  #     other_user = user_fixture()
  #     board = board_fixture(creator_id: other_user.id)

  #     conn = get(conn, Routes.board_path(conn, :show, board.id))

  #     assert redirected_to(conn) == Routes.board_path(conn, :index)
  #     assert get_flash(conn, :error) == "Board not found or you aren't creator."
  #   end

  #   test "redirect to :index when not found a board", %{conn: conn} do
  #     invalid_id = Ecto.UUID.generate()

  #     conn = get(conn, Routes.board_path(conn, :show, invalid_id))

  #     assert redirected_to(conn) == Routes.board_path(conn, :index)
  #     assert get_flash(conn, :error) == "Board not found or you aren't creator."
  #   end
  # end
end
