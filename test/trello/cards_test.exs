defmodule Trello.BoardsTest do
  use Trello.DataCase

  alias Trello.Boards.Card
  alias Trello.Cards
  import Trello.CardsFixtures

  describe "cards" do
    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Cards.get_card!(card.id) == card
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()

      update_attrs = %{
        title: "Sucesso",
        description: "Desc"
      }

      assert {:ok, %Card{} = card} = Cards.update_card(card, update_attrs)
      assert card.title == "Sucesso"
      assert card.description == "Desc"
    end
  end
end
