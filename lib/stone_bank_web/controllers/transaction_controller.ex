defmodule StoneBankWeb.TransactionController do
  use StoneBankWeb, :controller
  alias StoneBank.Transactions

  action_fallback StoneBankWeb.FallbackController
  plug :verify_permission when action in [:all, :year, :month, :day]

  def all(conn, _) do
    render(conn, "show.json", transaction: Transactions.all())
  end

  def year(conn, %{"year" => year}) do
    year = String.to_integer(year)
    render(conn, "show.json", transaction: Transactions.year(year))
  end

  def month(conn, %{"year" => year, "month" => month}) do
    year = String.to_integer(year)
    month = String.to_integer(month)
    render(conn, "show.json", transaction: Transactions.month(year, month))
  end

  def day(conn, %{"day" => day}) do
    render(conn, "show.json", transaction: Transactions.day(day))
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
