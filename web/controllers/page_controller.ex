defmodule FerForum.PageController do
  use FerForum.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
