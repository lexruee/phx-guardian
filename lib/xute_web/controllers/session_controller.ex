defmodule XuteWeb.SessionController do
  use XuteWeb, :controller

  alias Xute.{UserManager, UserManager.User, UserManager.Guardian}

  def new(conn, _params) do
    changeset = UserManager.change_user(%User{})
    maybe_user = Guardian.Plug.current_resource(conn)
    if maybe_user do
      redirect(conn, to: "/secret")
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end


  def login(conn, %{"user" => %{"username" => username, "password" => password}}) do

  end

  def logout(conn, _) do

  end
end