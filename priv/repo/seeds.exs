# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Trello.Repo.insert!(%Trello.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, fulano} =
  %{
    name: "Fulano",
    email: "fulano@example.com",
    password: "1234123412341234"
  }
  |> Trello.Accounts.register_user()

{:ok, cicrano} =
  %{
    name: "Cicrano",
    email: "cicrano@example.com",
    password: "1234123412341234"
  }
  |> Trello.Accounts.register_user()

["#735185"]
|> Enum.map(fn n ->
  {:ok, board} =
    Trello.Boards.create_board(%{
      name: "Estudos",
      active: true,
      background: n,
      creator_id: Enum.random([fulano.id, cicrano.id])
    })

  ["To do", "Doing", "Test", "Staging", "Production"]
  |> Enum.map(fn board_title ->
    list =
      board
      |> Ecto.build_assoc(:lists, title: board_title)
      |> Trello.Repo.insert!()

    if board_title == "To do" do
      counter = Enum.random([2, 3, 4, 5, 10, 15, 25])

      1..counter
      |> Enum.map(fn l ->
        list
        |> Ecto.build_assoc(:cards, title: "Card #{l}")
        |> Trello.Repo.insert!()
      end)
    end
  end)
end)
