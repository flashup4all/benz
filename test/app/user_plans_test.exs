defmodule App.UserPlansTest do
  use App.DataCase

  alias App.UserPlans

  describe "user_plans" do
    alias App.UserPlans.UserPlan

    @valid_attrs %{user_id: 42}
    @update_attrs %{user_id: 43}
    @invalid_attrs %{user_id: nil}

    def user_plan_fixture(attrs \\ %{}) do
      {:ok, user_plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserPlans.create_user_plan()

      user_plan
    end

    test "list_user_plans/0 returns all user_plans" do
      user_plan = user_plan_fixture()
      assert UserPlans.list_user_plans() == [user_plan]
    end

    test "get_user_plan!/1 returns the user_plan with given id" do
      user_plan = user_plan_fixture()
      assert UserPlans.get_user_plan!(user_plan.id) == user_plan
    end

    test "create_user_plan/1 with valid data creates a user_plan" do
      assert {:ok, %UserPlan{} = user_plan} = UserPlans.create_user_plan(@valid_attrs)
      assert user_plan.user_id == 42
    end

    test "create_user_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserPlans.create_user_plan(@invalid_attrs)
    end

    test "update_user_plan/2 with valid data updates the user_plan" do
      user_plan = user_plan_fixture()
      assert {:ok, %UserPlan{} = user_plan} = UserPlans.update_user_plan(user_plan, @update_attrs)
      assert user_plan.user_id == 43
    end

    test "update_user_plan/2 with invalid data returns error changeset" do
      user_plan = user_plan_fixture()
      assert {:error, %Ecto.Changeset{}} = UserPlans.update_user_plan(user_plan, @invalid_attrs)
      assert user_plan == UserPlans.get_user_plan!(user_plan.id)
    end

    test "delete_user_plan/1 deletes the user_plan" do
      user_plan = user_plan_fixture()
      assert {:ok, %UserPlan{}} = UserPlans.delete_user_plan(user_plan)
      assert_raise Ecto.NoResultsError, fn -> UserPlans.get_user_plan!(user_plan.id) end
    end

    test "change_user_plan/1 returns a user_plan changeset" do
      user_plan = user_plan_fixture()
      assert %Ecto.Changeset{} = UserPlans.change_user_plan(user_plan)
    end
  end
end
