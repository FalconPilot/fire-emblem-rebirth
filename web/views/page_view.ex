defmodule FerForum.PageView do
  use FerForum.Web, :view

  def is_online?(conn) do
    !!get_user(conn)
  end

  def get_username(conn) do
    get_user(conn).username
  end

  def get_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

  def welcome_message(conn) do
    if (is_online?(conn)) do
      "Bienvenue, #{get_username(conn)} !"
    else
      "Bienvenue !"
    end
  end

end
