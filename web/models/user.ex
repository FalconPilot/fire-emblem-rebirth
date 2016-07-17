defmodule FerForum.User do
  use FerForum.Web, :model

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :password_confirm, :string, virtual: true
    field :encrypted_password, :string
    field :email, :string
    field :privilege, :integer
    field :avatar, :string
    field :sheet, :map
    field :groups, {:array, :integer}
    field :ranks, {:array, :string}

    timestamps
  end

  @required_fields ~w(username password password_confirm email)
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
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:username, min: 3)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
  end

  # Create entry
  def create(changeset, repo) do
    password = encrypt_password(changeset.params["password"])
    changeset
    |> Ecto.Changeset.put_change(:encrypted_password, password)
    |> Ecto.Changeset.put_change(:privilege, 1)
    |> Ecto.Changeset.put_change(:avatar, "/images/noavatar.png")
    |> Ecto.Changeset.put_change(:sheet, %{})
    |> Ecto.Changeset.put_change(:groups, [])
    |> repo.insert()
  end

  # Encrypt password
  def encrypt_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

end
