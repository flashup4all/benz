defmodule AppWeb.UserPlanControllerTest do
  use AppWeb.ConnCase

  alias App.UserPlans
  alias App.UserPlans.UserPlan

  @create_attrs %{
    user_id: 42
  }
  @update_attrs %{
    user_id: 43
  }
  @invalid_attrs %{user_id: nil}

  def fixture(:user_plan) do
    {:ok, user_plan} = UserPlans.create_user_plan(@create_attrs)
    user_plan
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_plans", %{conn: conn} do
      conn = get(conn, Routes.user_plan_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_plan" do
    test "renders user_plan when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_plan_path(conn, :create), user_plan: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_plan_path(conn, :show, id))

      assert %{
               "id" => id,
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_plan_path(conn, :create), user_plan: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_plan" do
    setup [:create_user_plan]

    test "renders user_plan when data is valid", %{conn: conn, user_plan: %UserPlan{id: id} = user_plan} do
      conn = put(conn, Routes.user_plan_path(conn, :update, user_plan), user_plan: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_plan_path(conn, :show, id))

      assert %{
               "id" => id,
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_plan: user_plan} do
      conn = put(conn, Routes.user_plan_path(conn, :update, user_plan), user_plan: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_plan" do
    setup [:create_user_plan]

    test "deletes chosen user_plan", %{conn: conn, user_plan: user_plan} do
      conn = delete(conn, Routes.user_plan_path(conn, :delete, user_plan))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_plan_path(conn, :show, user_plan))
      end
    end
  end

  defp create_user_plan(_) do
    user_plan = fixture(:user_plan)
    {:ok, user_plan: user_plan}
  end
end
