defmodule XuteWeb.ViewHelper do
  alias Xute.UserManager.Guardian

  def current_user(conn), do: Guardian.Plug.current_resource(conn)
  def logged_in?(conn), do: Guardian.Plug.authenticated?(conn)
end