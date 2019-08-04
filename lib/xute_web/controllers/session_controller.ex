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
    UserManager.authenticate_user(username, password)
    |> login_reply(conn)
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> put_flash(:success, "Welcome back, #{user.username}!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/secret")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end
end