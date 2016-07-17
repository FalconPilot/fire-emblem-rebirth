defmodule FerForum.DataController do
  use FerForum.Web, :controller
  alias FerForum.User

  # Register a new user
  def user_create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)
    case User.create(changeset, FerForum.Repo) do
      {:ok, _changeset} ->
        conn
        |> put_flash(:info, "Le compte a été créé avec succès !")
        |> redirect(to: "/")
      {:error, changeset} ->
        IO.inspect changeset.errors
        conn
        |> put_flash(:error, "Erreur : certaines informations sont invalides !")
        |> redirect(to: "/register")
    end
  end

end
