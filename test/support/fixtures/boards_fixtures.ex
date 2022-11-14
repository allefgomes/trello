defmodule Trello.BoardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Trello.Boards` context.
  """

  @doc """
  Generate a board.
  """
  def board_fixture(attrs \\ %{}) do
    {:ok, board} =
      attrs
      |> Enum.into(%{
        active: true,
        background: "some background",
        name: "some name"
      })
      |> Trello.Boards.create_board()

    board
  end
end
