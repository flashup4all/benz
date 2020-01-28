defmodule AppWeb.AuthController do
  use AppWeb, :controller

  alias App.Accounts
  alias App.Accounts.User
  alias App.Guardian

  action_fallback AppWeb.FallbackController

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        IO.puts "++++++++"
        IO.inspect _claims
        IO.puts "++++++++"
        conn |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end
end
