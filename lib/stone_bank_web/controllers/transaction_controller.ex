defmodule StoneBankWeb.TransactionController do
  use StoneBankWeb, :controller
  alias StoneBank.Transactions

  action_fallback StoneBankWeb.FallbackController

  def all(conn, _) do
    render(conn, "show.json", transaction: Transactions.all())
  end

  def year(conn, %{"year" => year}) do
    render(conn, "show.json", transaction: Transactions.year(year))
  end

  def month(conn, %{"year" => year, "month" => month}) do
    render(conn, "show.json", transaction: Transactions.month(year, month))
  end

  def day(conn, %{"day" => day}) do
    render(conn, "show.json", transaction: Transactions.day(day))
  end
end