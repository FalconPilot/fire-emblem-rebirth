defmodule FerForum.Router do
  use FerForum.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FerForum do
    pipe_through :browser # Use the default browser stack

    # Get
    get   "/",              PageController,     :index
    get   "/register",      PageController,     :register
    get   "/userlist",      PageController,     :userlist
    get   "/user/p:id",     PageController,     :userpage

    # Post
    post  "/pannel",        PageController,     :admin_pannel
    post  "/pannel/users",  PageController,     :admin_users
    post  "/pannel/forums", PageController,     :admin_forums
    post  "/create",        DataController,     :user_create
    post  "/login",         SessionController,  :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", FerForum do
  #   pipe_through :api
  # end
end
