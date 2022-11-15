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

{:ok, user} = %{
  name: "user",
  email: "user@example.com",
  password: "1234123412341234"
}
|> Trello.Accounts.register_user()

user = Trello.Repo.one!(Trello.Boards.Creator)
1..20
|> Enum.map(fn n ->
  Trello.Boards.create_board(%{
    name: "Board #{n}",
    active: true,
    background: "#ccc",
    creator_id: user.id
  })
end)
