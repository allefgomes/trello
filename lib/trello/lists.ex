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
end
