defmodule Trello.CardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Trello.Boards` context.
  """

  import Trello.{ListsFixtures}

  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        title: "Teste",
        description: "Desc",
        list_id: valid_list_id()
      })
      |> Trello.Boards.create_card()

    card
  end

  defp valid_list_id do
    list = list_fixture()

    list.id
  end
end
