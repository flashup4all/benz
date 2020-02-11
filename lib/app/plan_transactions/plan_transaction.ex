defmodule App.PlanTransactions.PlanTransaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plans_transactions" do
    field :amount, :float
    field :current_balance, :float
    field :previous_balance, :float
    field :trans_type, :integer #1 - credit, 2 - debit
    field :status, :integer, default: 0 # 0 - pending, 1 - approved, 2 - declined, 3 - failed
    field :payment_channel, :string # transfer, online-paystack, cash,
    field :online_channel_ref, :string, null: true # transfer, online-paystack, cash,
    field :meta, :string, null: true
    field :interest_rate, :float
    field :current_interest_balance, :float, null: true
    field :no_days, :integer
    belongs_to :user, App.Accounts.User
    belongs_to :plan, App.Plans.Plan
    belongs_to :user_plan, App.UserPlans.UserPlan

    timestamps()
  end

  @doc false
  def changeset(plan_transaction, attrs) do
    plan_transaction
    |> cast(attrs, [:interest_rate, :no_days, :user_id, :plan_id, :user_plan_id, :current_balance, :previous_balance, :trans_type, :payment_channel, :status, :online_channel_ref, :meta, :amount, :current_interest_balance])
    |> validate_required([:user_id, :plan_id, :trans_type, :payment_channel, :amount, :user_id, :plan_id, :user_plan_id])
  end
end
