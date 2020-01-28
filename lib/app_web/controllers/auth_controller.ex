defmodule AppWeb.AuthController do
  use AppWeb, :controller

  alias App.Accounts
  alias App.Accounts.User
  alias App.Guardian

  action_fallback AppWeb.FallbackController

  @doc """
  validate user email and password
  generate jwt auth token.

  """
  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  @doc """
  Revoke jwt auth token.

  logout a user

  """
  def logout(conn, params) do
    jwt = Guardian.Plug.current_token(conn)
    check = App.Guardian.revoke(jwt)
    render("logout.json",status: "token destroyed")
  end
end
