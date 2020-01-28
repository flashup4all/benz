defmodule AppWeb.AuthView do
  use AppWeb, :view
  alias AppWeb.AuthView

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
