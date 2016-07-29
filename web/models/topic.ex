defmodule FerForum.Topic do
  use FerForum.Web, :model

  schema "topics" do
    field :name, :string
    field :parent, :integer
    field :subtopics, {:array, :integer}
    field :messages, {:array, :integer}

    timestamps
  end

  @required_fields ~w(name subtopics parent messages)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  # Create entry
  def create(changeset, repo) do
    changeset
    |> repo.insert()
  end
end
