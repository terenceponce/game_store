defmodule GameStoreWeb.Router do
  use GameStoreWeb, :router

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

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug GameStore.CurrentUser
  end

  scope "/", GameStoreWeb do
    pipe_through [:browser, :with_session] # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController, only: [:show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/games", GameController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GameStoreWeb do
  #   pipe_through :api
  # end
end
