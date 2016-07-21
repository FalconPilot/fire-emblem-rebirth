defmodule FerForum.Message do
  use FerForum.Web, :model

  schema "messages" do
    field :author, :integer
    field :title, :string
    field :posts, {:array, :integer}

    timestamps
  end

  @required_fields ~w(author title contents)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """

  # Changeset
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:title, min: 3)
    |> validate_length(:contents, min: 10)
  end

end
