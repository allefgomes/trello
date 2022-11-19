defmodule Trello.CardsTest do
  use Trello.DataCase

  alias Trello.Boards.{Board, Card, List}
  alias Trello.Boards
  import Trello.{AccountsFixtures, BoardsFixtures, ListsFixtures}

  describe "boards" do
    @invalid_attrs %{active: nil, background: nil, name: nil, creator_id: nil}

    test "list_boards/0 returns all boards" do
      board = board_fixture()

      assert Boards.list_boards(board.creator_id) == [board]
    end

    test "get_board_by_creator!/1 returns the board with given id and creator_id" do
      board = board_fixture()

      assert Boards.get_board_by_creator!(board.id, board.creator_id) == board
    end

    test "get_board!/1 returns the board with given id" do
      created_board = board_fixture()

      assert %Board{} = board = Boards.get_board!(created_board.id)

      assert created_board.id == board.id
      assert created_board.name == board.name
      assert created_board.active == board.active
      assert created_board.background == board.background
      assert created_board.creator_id == board.creator_id
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
      created_board = board_fixture()

      assert {:error, %Ecto.Changeset{}} = Boards.update_board(created_board, @invalid_attrs)

      assert %Board{} = board = Boards.get_board!(created_board.id)

      assert created_board.id == board.id
      assert created_board.name == board.name
      assert created_board.active == board.active
      assert created_board.background == board.background
      assert created_board.creator_id == board.creator_id
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

    test "create_list/1 with valid data creates a list" do
      %Board{} = board = board_fixture()

      valid_attrs = %{
        title: "Teste",
        board_id: board.id
      }

      assert {:ok, %List{} = list} = Boards.create_list(valid_attrs)
      assert list.title == "Teste"
    end

    test "create_card/1 with valid data creates a card" do
      %List{} = list = list_fixture()

      valid_attrs = %{
        title: "Teste",
        description: "Desc",
        list_id: list.id
      }

      assert {:ok, %Card{} = card} = Boards.create_card(valid_attrs)
      assert card.title == "Teste"
      assert card.description == "Desc"
    end
  end
end
