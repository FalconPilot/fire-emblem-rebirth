defmodule FerForum.Topic do
  use FerForum.Web, :model

  schema "topics" do
    field :name, :string
    field :subtopics, {:array, :integer}
    field :parents, {:array, :integer}
    field :messages, {:array, :integer}

    timestamps
  end

  @required_fields ~w(name subtopics messages)
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
end
