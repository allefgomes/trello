defmodule Trello.ListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Trello.Boards` context.
  """

  import Trello.{BoardsFixtures}

  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        title: "Teste",
        description: "Desc",
        board_id: valid_board_id()
      })
      |> Trello.Boards.create_list()

    list
  end

  defp valid_board_id do
    board_created = board_fixture()

    board_created.id
  end
end
