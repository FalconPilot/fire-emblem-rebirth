defmodule FerForum.PageController do
  use FerForum.Web, :controller
  alias FerForum.User
  alias FerForum.Topic

  # Get subtopics
  def get_subtopics([]) do
    []
  end

  def get_subtopics(list) do
    get_subtopics(list, [])
  end

  def get_subtopics([h|t], acc) do
    topic = Repo.get!(Topic, h)
    acc = acc ++ [topic]
    get_subtopics(t, acc)
  end

  def get_subtopics([], acc) do
    acc
  end

  # Get subtopics list

  def get_list([]) do
    []
  end

  def get_list(list) do
    get_list(list, [])
  end

  def get_list([h|t], acc) do
    acc = acc ++ get_subtopics(h.subtopics)
    get_list(t, acc)
  end

  def get_list([], acc) do
    acc
  end

  # Index
  def index(conn, _params) do
    changeset = User.changeset(%User{})
    master = listconv(Repo.get_by(Topic, parent: 0))
    sublist = get_list(master)
    IO.inspect(sublist)
    conn
    |> assign(:changeset, changeset)
    |> assign(:master, master)
    |> assign(:sublist, sublist)
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
    forumset = Topic.changeset(%Topic{})
    master = listconv(Repo.get_by(Topic, parent: 0))
    conn
    |> assign(:changeset, changeset)
    |> assign(:forumset, forumset)
    |> assign(:master, master)
    |> render("admin_forums.html")
  end

  # Convert to list
  def listconv(nil) do
    nil
  end

  def listconv([elem]) do
    [elem]
  end

  def listconv(elem) do
    [elem]
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
