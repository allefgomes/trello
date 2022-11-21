defmodule Trello.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :list_id, references(:lists, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:cards, [:list_id])
  end
end
