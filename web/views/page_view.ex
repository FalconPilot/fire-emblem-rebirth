defmodule FerForum.PageView do
  use FerForum.Web, :view

  # User regular methods
  def is_online?(conn) do
    !!get_user(conn)
  end

  def get_username(conn) do
    get_user(conn).username
  end

  def get_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end

  # Index welcome message
  def welcome_message(conn) do
    if (is_online?(conn)) do
      "Bienvenue, #{get_username(conn)} !"
    else
      "Bienvenue !"
    end
  end

  # User profile method
  def get_profile(user) do
    firstchar = String.downcase(String.first(user.username))
    case is_vowel?(firstchar) do
      true ->
        "Profil d'" <> user.username
      false ->
        "Profil de " <> user.username
    end
  end

  # Check if char is vowel
  def is_vowel?(char) do
    case char do
      "a" ->
        true
      "e" ->
        true
      "i" ->
        true
      "o" ->
        true
      "u" ->
        true
      "y" ->
        true
      _   ->
        false
    end
  end

end
