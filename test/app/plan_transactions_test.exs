defmodule App.PlanTransactionsTest do
  use App.DataCase

  alias App.PlanTransactions

  describe "plans_transactions" do
    alias App.PlanTransactions.PlanTransaction

    @valid_attrs %{user_id: 42}
    @update_attrs %{user_id: 43}
    @invalid_attrs %{user_id: nil}

    def plan_transaction_fixture(attrs \\ %{}) do
      {:ok, plan_transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PlanTransactions.create_plan_transaction()

      plan_transaction
    end

    test "list_plans_transactions/0 returns all plans_transactions" do
      plan_transaction = plan_transaction_fixture()
      assert PlanTransactions.list_plans_transactions() == [plan_transaction]
    end

    test "get_plan_transaction!/1 returns the plan_transaction with given id" do
      plan_transaction = plan_transaction_fixture()
      assert PlanTransactions.get_plan_transaction!(plan_transaction.id) == plan_transaction
    end

    test "create_plan_transaction/1 with valid data creates a plan_transaction" do
      assert {:ok, %PlanTransaction{} = plan_transaction} = PlanTransactions.create_plan_transaction(@valid_attrs)
      assert plan_transaction.user_id == 42
    end

    test "create_plan_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PlanTransactions.create_plan_transaction(@invalid_attrs)
    end

    test "update_plan_transaction/2 with valid data updates the plan_transaction" do
      plan_transaction = plan_transaction_fixture()
      assert {:ok, %PlanTransaction{} = plan_transaction} = PlanTransactions.update_plan_transaction(plan_transaction, @update_attrs)
      assert plan_transaction.user_id == 43
    end

    test "update_plan_transaction/2 with invalid data returns error changeset" do
      plan_transaction = plan_transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = PlanTransactions.update_plan_transaction(plan_transaction, @invalid_attrs)
      assert plan_transaction == PlanTransactions.get_plan_transaction!(plan_transaction.id)
    end

    test "delete_plan_transaction/1 deletes the plan_transaction" do
      plan_transaction = plan_transaction_fixture()
      assert {:ok, %PlanTransaction{}} = PlanTransactions.delete_plan_transaction(plan_transaction)
      assert_raise Ecto.NoResultsError, fn -> PlanTransactions.get_plan_transaction!(plan_transaction.id) end
    end

    test "change_plan_transaction/1 returns a plan_transaction changeset" do
      plan_transaction = plan_transaction_fixture()
      assert %Ecto.Changeset{} = PlanTransactions.change_plan_transaction(plan_transaction)
    end
  end
end
