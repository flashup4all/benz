defmodule AppWeb.Plugs.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :app,
  module: App.Guardian,
  error_handler: AppWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end