defmodule StoneBankWeb.TransactionView do
  use StoneBankWeb, :view

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, __MODULE__, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    transactions_list =
      Enum.map(transaction.transactions, fn t ->
        %{
          date: t.date,
          account_from: t.account_from,
          accounts_to: t.account_to,
          type: t.type,
          value: t.value
        }
      end)

    %{transactions_list: transactions_list, total: transaction.total}
  end
end
