defmodule FerForum.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :author, :integer
      add :title, :string
      add :contents, :string

      timestamps
    end

  end
end
