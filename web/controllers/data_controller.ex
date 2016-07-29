defmodule FerForum.DataController do
  use FerForum.Web, :controller
  alias FerForum.User
  alias FerForum.Topic

  # Register a new user
  def user_create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)
    case User.create(changeset, FerForum.Repo) do
      {:ok, _changeset} ->
        conn
        |> put_flash(:info, "Le compte a été créé avec succès !")
        |> redirect(to: "/")
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Erreur : certaines informations sont invalides !")
        |> redirect(to: "/register")
    end
  end

  # Create a new root forum
  def forum_create(conn, %{"topic" => params}) do
    if (!Map.has_key?(params, "parent")) do
      params = Map.merge(params, %{"parent" => 0})
    else
      parent = Repo.get_by(Topic, id: params["parent"])
    end
    params =  Map.merge(params, %{"subtopics" => [], "messages" => []})
    changeset = Topic.changeset(%Topic{}, params)
    case Topic.create(changeset, FerForum.Repo) do
      {:ok, changeset} ->
        if (parent) do
          list = parent.subtopics ++ [changeset.id]
          IO.inspect(changeset.id)
          parent = Ecto.Changeset.change(parent, subtopics: list)
          Repo.update(parent)
        end
        conn
        |> put_flash(:info, "Forum créé avec succès !")
        |> redirect(to: "/pannel/forums")
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Erreur : le nom doit faire au moins 3 caractères !")
        |> redirect(to: "/pannel/forums")
    end
  end

end
