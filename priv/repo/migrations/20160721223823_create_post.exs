defmodule FerForum.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :author, :integer
      add :contents, :string

      timestamps
    end

  end
end
