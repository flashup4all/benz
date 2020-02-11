defmodule App.Repo.Migrations.CreatePlansTransactions do
  use Ecto.Migration

  def change do
    create table(:plans_transactions) do
      add :user_id, references(:users)
      add :plan_id, references(:plans)
      add :user_plan_id, references(:user_plans)
      add :amount, :float
      add :interest_rate, :float
      add :current_balance, :float
      add :previous_balance, :float
      add :current_interest_balance, :float
      add :no_days, :integer
      add :trans_type, :integer #1 - credit, 2 - debit
      add :status, :integer, default: 0 # 0 - pending, 1 - approved, 2 - declined, 3 - failed
      add :payment_channel, :string # transfer, online-paystack, cash,
      add :online_channel_ref, :string, null: true # transfer, online-paystack, cash,
      add :meta, :string, null: true # extras
      timestamps()
    end

  end
end
