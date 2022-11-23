defmodule Trello.Boards.Entities.Card do
  use Ecto.Schema
  import Ecto.Changeset

  alias Trello.Boards.Entities.List

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :description, :string
    field :title, :string

    belongs_to :list, List

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:title, :description, :list_id])
    |> validate_required([:list_id])
  end
end
