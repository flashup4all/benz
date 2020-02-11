defmodule AppWeb.PlanTransactionControllerTest do
  use AppWeb.ConnCase

  alias App.PlanTransactions
  alias App.PlanTransactions.PlanTransaction

  @create_attrs %{
    user_id: 42
  }
  @update_attrs %{
    user_id: 43
  }
  @invalid_attrs %{user_id: nil}

  def fixture(:plan_transaction) do
    {:ok, plan_transaction} = PlanTransactions.create_plan_transaction(@create_attrs)
    plan_transaction
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all plans_transactions", %{conn: conn} do
      conn = get(conn, Routes.plan_transaction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create plan_transaction" do
    test "renders plan_transaction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.plan_transaction_path(conn, :create), plan_transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.plan_transaction_path(conn, :show, id))

      assert %{
               "id" => id,
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.plan_transaction_path(conn, :create), plan_transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update plan_transaction" do
    setup [:create_plan_transaction]

    test "renders plan_transaction when data is valid", %{conn: conn, plan_transaction: %PlanTransaction{id: id} = plan_transaction} do
      conn = put(conn, Routes.plan_transaction_path(conn, :update, plan_transaction), plan_transaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.plan_transaction_path(conn, :show, id))

      assert %{
               "id" => id,
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, plan_transaction: plan_transaction} do
      conn = put(conn, Routes.plan_transaction_path(conn, :update, plan_transaction), plan_transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete plan_transaction" do
    setup [:create_plan_transaction]

    test "deletes chosen plan_transaction", %{conn: conn, plan_transaction: plan_transaction} do
      conn = delete(conn, Routes.plan_transaction_path(conn, :delete, plan_transaction))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.plan_transaction_path(conn, :show, plan_transaction))
      end
    end
  end

  defp create_plan_transaction(_) do
    plan_transaction = fixture(:plan_transaction)
    {:ok, plan_transaction: plan_transaction}
  end
end
