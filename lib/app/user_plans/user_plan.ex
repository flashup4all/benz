defmodule App.UserPlans.UserPlan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_plans" do
    field :status, :integer, default: 0
    belongs_to :user, App.Accounts.User
    belongs_to :plan, App.Plans.Plan

    timestamps()
  end

  @doc false
  def changeset(user_plan, attrs) do
    user_plan
    |> cast(attrs, [:user_id, :plan_id, :status])
    |> validate_required([:user_id, :plan_id])
  end
end
