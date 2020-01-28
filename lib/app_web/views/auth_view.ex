defmodule AppWeb.AuthView do
  use AppWeb, :view
  alias AppWeb.AuthView

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("logout.json", %{status: status}) do
    %{status: status}
  end
end
