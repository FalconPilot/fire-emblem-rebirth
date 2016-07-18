defmodule FerForum.LayoutView do
  use FerForum.Web, :view

  # Check if user is online
  def is_online?(conn) do
    !!get_user(conn)
  end

  # Get username
  def get_username(conn) do
    get_user(conn).username
  end

  # Get user in session
  def get_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

  # Get user group
  def user_group(conn) do
    get_user(conn).group
  end

  # Check if user is privileged
  def is_allowed?(conn) do
    if (is_online?(conn)) do
      get_user(conn).privilege >= 1
    else
      false
    end
  end

end
