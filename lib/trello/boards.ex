defmodule Trello.Boards do
  @moduledoc """
  The Boards context.
  """

  import Ecto.Query, warn: false
  alias Trello.Repo

  alias Trello.Boards.{Board, Card, List}

  def create_list(attrs \\ %{}) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of boards.

  ## Examples

      iex> list_boards(creator_id)
      [%Board{}, ...]

  """
  def list_boards(creator_id) do
    query =
      from b in Board,
        where: b.creator_id == ^creator_id,
        order_by: b.updated_at

    Repo.all(query)
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id), do: Repo.get!(Board, id) |> Repo.preload(lists: :cards)

  # Board
  # |> join: c in assoc(p, :comments),
  # |> where([b], b.id == "d2d019bc-010d-4cc9-9902-f3ada676d6e1")
  # |> preload(lists: :cards)
  # |> Repo.all

  # import Ecto.Query, warn: false
  # alias Trello.Repo

  # alias Trello.Boards.{Board, List, Card}

  # board_id = "d2d019bc-010d-4cc9-9902-f3ada676d6e1"
  # query = from b in Board,
  #   join: l in assoc(b, :lists),
  #   join: c in assoc(l, :cards),
  #   where: b.id == ^board_id,
  #   preload: [lists: {l, cards: c}]

  # query
  # |> Repo.one!

  # d2d019bc-010d-4cc9-9902-f3ada676d6e1

  @doc """
  Gets a single board by creator_id and id.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123, 123)
      %Board{}

      iex> get_board!(456, 0)
      ** (Ecto.NoResultsError)

  """
  def get_board_by_creator!(id, creator_id) do
    Board
    |> where(id: ^id)
    |> where(creator_id: ^creator_id)
    |> Repo.one()
    |> Repo.preload(lists: :cards)
  end

  @doc """
  Creates a board.

  ## Examples

      iex> create_board(%{field: value})
      {:ok, %Board{}}

      iex> create_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_board(attrs \\ %{}) do
    %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a board.

  ## Examples

      iex> update_board(board, %{field: new_value})
      {:ok, %Board{}}

      iex> update_board(board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a board.

  ## Examples

      iex> delete_board(board)
      {:ok, %Board{}}

      iex> delete_board(board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{data: %Board{}}

  """
  def change_board(%Board{} = board, attrs \\ %{}) do
    Board.changeset(board, attrs)
  end
end
