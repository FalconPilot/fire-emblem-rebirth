defmodule FerForum.SessionController do
  use FerForum.Web, :controller
  alias FerForum.User

  # Login
  def login(conn, %{"user" => params}) do
    IO.inspect params
    conn
    |> redirect(to: "/")
  end

end
