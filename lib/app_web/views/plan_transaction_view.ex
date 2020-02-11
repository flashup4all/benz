defmodule AppWeb.PlanTransactionView do
  use AppWeb, :view
  alias AppWeb.PlanTransactionView

  def render("index.json", %{plans_transactions: plans_transactions}) do
    %{data: render_many(plans_transactions, PlanTransactionView, "plan_transaction.json")}
  end

  def render("show.json", %{plan_transaction: plan_transaction}) do
    %{data: render_one(plan_transaction, PlanTransactionView, "plan_transaction.json")}
  end

  def render("plan_transaction.json", %{plan_transaction: plan_transaction}) do
    %{
      id: plan_transaction.id,
      user_id: plan_transaction.user_id,
      user_plan_id: plan_transaction.user_plan_id,
      current_balance: plan_transaction.current_balance,
      previous_balance: plan_transaction.previous_balance,
      trans_type: plan_transaction.trans_type,
      status: plan_transaction.status,
      payment_channel: plan_transaction.payment_channel,
      online_channel_ref: plan_transaction.online_channel_ref,
      meta: plan_transaction.meta,
      amount: plan_transaction.amount,
      current_interest_balance: plan_transaction.current_interest_balance,
      interest_rate: plan_transaction.interest_rate,
      no_days: plan_transaction.no_days
    }
  end
  def render("error.json", %{status: status, msg: msg}) do
    %{
      status: status,
      msg: msg
    }
  end
end
