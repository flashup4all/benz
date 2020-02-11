defmodule AppWeb.PlanControllerTest do
  use AppWeb.ConnCase

  alias App.Plans
  alias App.Plans.Plan

  @create_attrs %{
    company_interest: 120.5,
    description: "some description",
    interest: 120.5,
    interest_type: "some interest_type",
    minimum_amount: 120.5,
    name: "some name",
    partner_interest: 120.5,
    type: "some type"
  }
  @update_attrs %{
    company_interest: 456.7,
    description: "some updated description",
    interest: 456.7,
    interest_type: "some updated interest_type",
    minimum_amount: 456.7,
    name: "some updated name",
    partner_interest: 456.7,
    type: "some updated type"
  }
  @invalid_attrs %{company_interest: nil, description: nil, interest: nil, interest_type: nil, minimum_amount: nil, name: nil, partner_interest: nil, type: nil}

  def fixture(:plan) do
    {:ok, plan} = Plans.create_plan(@create_attrs)
    plan
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all plans", %{conn: conn} do
      conn = get(conn, Routes.plan_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create plan" do
    test "renders plan when data is valid", %{conn: conn} do
      conn = post(conn, Routes.plan_path(conn, :create), plan: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.plan_path(conn, :show, id))

      assert %{
               "id" => id,
               "company_interest" => 120.5,
               "description" => "some description",
               "interest" => 120.5,
               "interest_type" => "some interest_type",
               "minimum_amount" => 120.5,
               "name" => "some name",
               "partner_interest" => 120.5,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.plan_path(conn, :create), plan: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update plan" do
    setup [:create_plan]

    test "renders plan when data is valid", %{conn: conn, plan: %Plan{id: id} = plan} do
      conn = put(conn, Routes.plan_path(conn, :update, plan), plan: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.plan_path(conn, :show, id))

      assert %{
               "id" => id,
               "company_interest" => 456.7,
               "description" => "some updated description",
               "interest" => 456.7,
               "interest_type" => "some updated interest_type",
               "minimum_amount" => 456.7,
               "name" => "some updated name",
               "partner_interest" => 456.7,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, plan: plan} do
      conn = put(conn, Routes.plan_path(conn, :update, plan), plan: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete plan" do
    setup [:create_plan]

    test "deletes chosen plan", %{conn: conn, plan: plan} do
      conn = delete(conn, Routes.plan_path(conn, :delete, plan))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.plan_path(conn, :show, plan))
      end
    end
  end

  defp create_plan(_) do
    plan = fixture(:plan)
    {:ok, plan: plan}
  end
end
