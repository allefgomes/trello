defmodule Trello.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :active, :boolean, default: false, null: false
      add :background, :string
      add :owner, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:boards, [:owner])
  end
end
