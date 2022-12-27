defmodule Trello.Cards do
  @moduledoc """
  The Cards context.
  """

  import Ecto.Query, warn: false
  alias Trello.Repo

  alias Trello.Boards.Card

  def get_card!(id), do: Repo.get!(Card, id)

  def update_card(%Card{} = card, attrs) do
    card
    |> Card.changeset(attrs)
    |> Repo.update()
  end

  def new(attrs \\ %{}) do
    Card.changeset(%Card{}, attrs)
  end

  def change_card(%Card{} = card, attrs \\ %{}) do
    Card.changeset(card, attrs)
  end


  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end
end
