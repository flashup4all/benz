defmodule App.PlansTest do
  use App.DataCase

  alias App.Plans

  describe "plans" do
    alias App.Plans.Plan

    @valid_attrs %{company_interest: 120.5, description: "some description", interest: 120.5, interest_type: "some interest_type", minimum_amount: 120.5, name: "some name", partner_interest: 120.5, type: "some type"}
    @update_attrs %{company_interest: 456.7, description: "some updated description", interest: 456.7, interest_type: "some updated interest_type", minimum_amount: 456.7, name: "some updated name", partner_interest: 456.7, type: "some updated type"}
    @invalid_attrs %{company_interest: nil, description: nil, interest: nil, interest_type: nil, minimum_amount: nil, name: nil, partner_interest: nil, type: nil}

    def plan_fixture(attrs \\ %{}) do
      {:ok, plan} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Plans.create_plan()

      plan
    end

    test "list_plans/0 returns all plans" do
      plan = plan_fixture()
      assert Plans.list_plans() == [plan]
    end

    test "get_plan!/1 returns the plan with given id" do
      plan = plan_fixture()
      assert Plans.get_plan!(plan.id) == plan
    end

    test "create_plan/1 with valid data creates a plan" do
      assert {:ok, %Plan{} = plan} = Plans.create_plan(@valid_attrs)
      assert plan.company_interest == 120.5
      assert plan.description == "some description"
      assert plan.interest == 120.5
      assert plan.interest_type == "some interest_type"
      assert plan.minimum_amount == 120.5
      assert plan.name == "some name"
      assert plan.partner_interest == 120.5
      assert plan.type == "some type"
    end

    test "create_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Plans.create_plan(@invalid_attrs)
    end

    test "update_plan/2 with valid data updates the plan" do
      plan = plan_fixture()
      assert {:ok, %Plan{} = plan} = Plans.update_plan(plan, @update_attrs)
      assert plan.company_interest == 456.7
      assert plan.description == "some updated description"
      assert plan.interest == 456.7
      assert plan.interest_type == "some updated interest_type"
      assert plan.minimum_amount == 456.7
      assert plan.name == "some updated name"
      assert plan.partner_interest == 456.7
      assert plan.type == "some updated type"
    end

    test "update_plan/2 with invalid data returns error changeset" do
      plan = plan_fixture()
      assert {:error, %Ecto.Changeset{}} = Plans.update_plan(plan, @invalid_attrs)
      assert plan == Plans.get_plan!(plan.id)
    end

    test "delete_plan/1 deletes the plan" do
      plan = plan_fixture()
      assert {:ok, %Plan{}} = Plans.delete_plan(plan)
      assert_raise Ecto.NoResultsError, fn -> Plans.get_plan!(plan.id) end
    end

    test "change_plan/1 returns a plan changeset" do
      plan = plan_fixture()
      assert %Ecto.Changeset{} = Plans.change_plan(plan)
    end
  end
end
