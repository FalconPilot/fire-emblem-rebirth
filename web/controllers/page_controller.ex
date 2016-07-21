defmodule FerForum.PageController do
  use FerForum.Web, :controller
  alias FerForum.User

  # Index
  def index(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  # Registration page
  def register(conn, _params) do
    changeset = User.changeset(%User{})
    if (get_session(conn, :current_user)) do
      conn
      |> put_flash(:error, "Accès refusé !")
      |> redirect(to: "/")
    else
      conn
      |> assign(:changeset, changeset)
      |> render("register.html")
    end
  end

  # Userlist
  def userlist(conn, _params) do
    userlist = Repo.all(User)
    changeset = User.changeset(%User{})
    conn
    |> assign(:userlist, userlist)
    |> assign(:changeset, changeset)
    |> render("userlist.html")
  end

  # Userpage
  def userpage(conn, %{"id" => uid}) do
    user = Repo.get_by(User, id: String.to_integer(uid))
    changeset = User.changeset(%User{})
    conn
    |> assign(:pageuser, user)
    |> assign(:changeset, changeset)
    |> render("userpage.html")
  end

  # Admin pannel
  def admin_pannel(conn, _params) do
    if (is_allowed?(conn)) do
      changeset = User.changeset(%User{})
      conn
      |> assign(:changeset, changeset)
      |> render("admin_hub.html")
    else
      unauthorized(conn)
    end
  end

  # Admin users
  def admin_users(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> assign(:changeset, changeset)
    |> render("admin_users.html")
  end

  # Admin Forums
  def admin_forums(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> assign(:changeset, changeset)
    |> render("admin_forums.html")
  end

  # Unauthorized page
  def unauthorized(conn) do
    conn
    |> put_flash(:error, "Erreur : accès refusé")
    |> redirect(to: "/")
  end

  # Privilege levels
  # 0 = member
  # 1 = admin
  # 2 = founder

  # Check if access is authorized
  def is_allowed?(conn) do
    user = Plug.Conn.get_session(conn, :current_user)
    if (user) do
      user.privilege >= 1
    else
      false
    end
  end

end
