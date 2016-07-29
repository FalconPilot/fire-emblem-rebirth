defmodule FerForum.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :author, :integer
      add :title, :string
      add :contents, :string
      add :type, :integer

      timestamps
    end

  end
end
