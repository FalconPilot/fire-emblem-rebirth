ExUnit.start

Mix.Task.run "ecto.create", ~w(-r FerForum.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r FerForum.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(FerForum.Repo)

