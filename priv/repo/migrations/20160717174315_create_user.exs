defmodule FerForum.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :encrypted_password, :string
      add :email, :string
      add :privilege, :integer
      add :avatar, :string
      add :sheet, :map
      add :groups, {:array, :integer}
      add :ranks, {:array, :string}

      timestamps
    end
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])

  end
end
