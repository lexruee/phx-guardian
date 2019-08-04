defmodule XuteWeb.PageController do
  use XuteWeb, :controller

  def secret(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "secret.html", current_user: user)
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
