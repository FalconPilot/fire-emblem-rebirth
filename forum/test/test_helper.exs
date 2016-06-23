ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Forum.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Forum.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Forum.Repo)

