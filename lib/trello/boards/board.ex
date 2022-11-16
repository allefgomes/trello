defmodule Trello.Boards.Board do
  use Ecto.Schema
  import Ecto.Changeset

  alias Trello.Boards.Creator

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "boards" do
    field :active, :boolean, default: false
    field :background, :string
    field :name, :string

    belongs_to :creator, Creator

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :active, :background, :creator_id])
    |> validate_required([:name, :active, :creator_id])
    |> validate_background()
  end

  defp validate_background(changeset) do
    changeset
    |> validate_required([:background])
    |> validate_format(:background, ~r/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/,
      message: "has invalid format. Please enter with an hex color."
    )
  end
end
