defmodule App.Repo.Migrations.CreateUserPlans do
  use Ecto.Migration

  def change do
    create table(:user_plans) do
      add :user_id, references(:users)
      add :plan_id, references(:plans)
      add :status, :integer, default: 0 # 0 - pending, 1 - active, 2 - closed
      timestamps()
    end

  end
end
