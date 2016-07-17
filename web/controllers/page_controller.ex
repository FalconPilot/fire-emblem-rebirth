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
end
