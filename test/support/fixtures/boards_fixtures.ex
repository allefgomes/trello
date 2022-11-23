defmodule Trello.BoardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Trello.Boards` context.
  """

  import Trello.AccountsFixtures

  @doc """
  Generate attributes map for new board
  """
  def valid_board_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: "sample name",
      active: true,
      background: "#fcc",
      creator_id: valid_creator_id()
    })
  end

  @doc """
  Generate a board.
  """
  def board_fixture(attrs \\ %{}) do
    {:ok, board} =
      attrs
      |> Enum.into(%{
        active: true,
        background: "#ccc",
        name: "some name",
        creator_id: valid_creator_id()
      })
      |> Trello.Boards.create_board()

    board
  end

  defp valid_creator_id do
    user_created = user_fixture()

    creator = Trello.Repo.get!(Trello.Boards.Entities.Creator, user_created.id)

    creator.id
  end
end
