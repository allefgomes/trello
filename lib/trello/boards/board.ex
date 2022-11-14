defmodule Trello.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "boards" do
    field :active, :boolean, default: false
    field :background, :string
    field :name, :string
    field :owner, :binary_id

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :active, :background])
    |> validate_required([:name, :active, :background])
  end
end
