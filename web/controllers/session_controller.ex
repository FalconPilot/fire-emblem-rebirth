defmodule FerForum.SessionController do
  use FerForum.Web, :controller
  alias FerForum.User

  # Login
  def login(conn, %{"user" => params}) do
    case userlog(params, FerForum.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, "Connexion confirmée !")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:error, "Erreur : identifiants incorrects !")
        |> redirect(to: "/")
    end
    conn
    |> redirect(to: "/")
  end

  # Session login try
  def userlog(params, repo) do
    user = repo.get_by(User, username: params["username"])
    case verify(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  # Verify password
  def verify(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
    end
  end

  # Logout
  def logout(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "À la prochaine !")
    |> redirect(to: "/")
  end

end
