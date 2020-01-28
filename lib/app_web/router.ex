defmodule AppWeb.Router do
  use AppWeb, :router
  # alias App.Guardian
  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug AppWeb.Plugs.AuthPipeline
  end
  scope "/api/v1", AppWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create, :show]
    post "/signin", AuthController, :sign_in
  end

  # authenticated scope
  scope "/api/v1", AppWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/users", UserController, :auth_user
    get "/logout", AuthController, :logout

  end
end
