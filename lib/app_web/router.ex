defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", AppWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create, :show]
    post "/signin", AuthController, :sign_in
  end
end
