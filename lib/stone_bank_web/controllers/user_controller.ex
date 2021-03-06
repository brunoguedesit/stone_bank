defmodule StoneBankWeb.UserController do
  use StoneBankWeb, :controller
  alias StoneBank.Accounts
  alias StoneBank.Accounts.Auth.Guardian

  action_fallback StoneBankWeb.FallbackController
  plug :verify_permission when action in [:show, :index]

  def signup(conn, %{"user" => user}) do
    with {:ok, user, account} <- Accounts.create_user(user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, id: user.id))
      |> render("account.json", %{user: user, account: account})
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user_auth.json", user: user, token: token)
    end
  end

  def index(conn, _) do
    conn
    |> render("index.json", users: Accounts.get_users())
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    conn
    |> render("show.json", %{user: user})
  end

  def balance(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    account = Accounts.get!(user.accounts.id)

    conn
    |> render("balance.json", %{user: user, account: account})
  end

  defp verify_permission(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    if user.role == "admin" do
      conn
    else
      conn
      |> put_status(401)
      |> json(%{error: "unauthorized"})
    end
  end
end
