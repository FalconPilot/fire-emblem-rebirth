defmodule FerForum.Repo.Migrations.CreateTopic do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :name, :string
      add :subtopics, {:array, :integer}
      add :parents, {:array, :integer}
      add :messages, {:array, :integer}

      timestamps
    end

  end
end
