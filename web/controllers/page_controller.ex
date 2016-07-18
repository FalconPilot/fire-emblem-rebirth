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
    conn
    |> assign(:changeset, changeset)
    |> render("register.html")
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
    changeset = User.changeset(%User{})
    conn
    |> assign(:changeset, changeset)
    |> render("admin_hub.html")
  end

  # Admin users
  def admin_users(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> assign(:changeset, changeset)
    |> render("admin_users.html")
  end

end
