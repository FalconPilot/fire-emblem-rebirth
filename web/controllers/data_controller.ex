defmodule FerForum.DataController do
  use FerForum.Web, :controller
  alias FerForum.User

  # Register a new user
  def user_create(conn, params) do
    if (params["user"]) do
      params = params["user"]
    end
    changeset = User.changeset(%User{}, params)
    case User.create(changeset, FerForum.Repo) do
      {:ok, _changeset} ->
        conn
        |> put_flash(:info, "Le compte a été créé avec succès !")
        |> redirect(to: "/")
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Erreur : certains informations sont invalides !")
        |> redirect(to: "/register")
    end
  end

end
