defmodule Trello.Boards.Entities.List do
  use Ecto.Schema
  import Ecto.Changeset

  alias Trello.Boards.Entities.{Board, Card}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "lists" do
    field :title, :string

    belongs_to :board, Board

    has_many :cards, Card

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title, :board_id])
  end
end
