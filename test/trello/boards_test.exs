defmodule Trello.BoardsTest do
  use Trello.DataCase

  alias Trello.Boards

  describe "boards" do
    alias Trello.Boards.Board

    import Trello.BoardsFixtures
    import Trello.AccountsFixtures

    @invalid_attrs %{active: nil, background: nil, name: nil, creator_id: nil}

    test "list_boards/0 returns all boards" do
      board = board_fixture()

      assert Boards.list_boards(board.creator_id) == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Boards.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      user = user_fixture()

      valid_attrs = %{
        active: true,
        background: "#cfc",
        name: "some name",
        creator_id: user.id
      }

      assert {:ok, %Board{} = board} = Boards.create_board(valid_attrs)
      assert board.active == true
      assert board.background == "#cfc"
      assert board.name == "some name"
      assert board.creator_id == user.id
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boards.create_board(@invalid_attrs)
    end

    test "create_board/1 with invalid background format returns error changeset" do
      user = user_fixture()

      attrs = %{
        active: true,
        background: "some background",
        name: "some name",
        creator_id: user.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Boards.create_board(attrs)

      assert %{background: ["has invalid format. Please enter with an hex color."]} =
               errors_on(changeset)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()

      update_attrs = %{
        active: false,
        background: "#c0c",
        name: "some updated name"
      }

      assert {:ok, %Board{} = board} = Boards.update_board(board, update_attrs)
      assert board.active == false
      assert board.background == "#c0c"
      assert board.name == "some updated name"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Boards.update_board(board, @invalid_attrs)
      assert board == Boards.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Boards.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Boards.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Boards.change_board(board)
    end
  end
end
