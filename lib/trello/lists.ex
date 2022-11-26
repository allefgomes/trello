defmodule Trello.Lists do
  @moduledoc """
  The Cards context.
  """

  import Ecto.Query, warn: false
  alias Trello.Repo

  alias Trello.Boards.List

  def create_list(attrs \\ %{}) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  def change_list(%List{} = list, attrs \\ %{}) do
    List.changeset(list, attrs)
  end
end
