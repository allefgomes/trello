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
end
