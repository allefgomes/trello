defmodule Trello.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :board_id, references(:boards, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
  end
end
