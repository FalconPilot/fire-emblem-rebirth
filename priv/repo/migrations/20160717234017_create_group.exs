defmodule FerForum.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :members, {:array, :string}

      timestamps
    end

  end
end
