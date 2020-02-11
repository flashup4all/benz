defmodule AppWeb.UserPlanController do
  use AppWeb, :controller

  alias App.UserPlans
  alias App.UserPlans.UserPlan

  action_fallback AppWeb.FallbackController

  def index(conn, params) do
    page = UserPlans.list_user_plans(params)
    paginator = %{
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
    render(conn, "index.json", user_plans: page.entries, paginator: paginator)
  end

  def user_subscribed_plans(conn, %{"user_id" => user_id } = params) do
    page = UserPlans.list_user_subscribed_plans(user_id, params)
    paginator = %{
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
    render(conn, "index.json", user_plans: page.entries, paginator: paginator)
  end

  def create(conn, %{"user_plan" => user_plan_params}) do
    #check if data already exist
    unless UserPlans.check_if_user_already_subscribe(user_plan_params) do
      with {:ok, %UserPlan{} = user_plan} <- UserPlans.create_user_plan(user_plan_params) do
        IO.inspect user_plan
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_plan_path(conn, :show, user_plan))
        |> render("show.json", user_plan: user_plan)
      end
    end
    conn |> render("error.json", status: "error", msg: "You are already subscribed to this plan")
  end

  def show(conn, %{"id" => id}) do
    user_plan = UserPlans.get_user_plan!(id)
    render(conn, "show.json", user_plan: user_plan)
  end

  def update(conn, %{"id" => id, "user_plan" => user_plan_params}) do
    user_plan = UserPlans.get_user_plan!(id)

    with {:ok, %UserPlan{} = user_plan} <- UserPlans.update_user_plan(user_plan, user_plan_params) do
      render(conn, "show.json", user_plan: user_plan)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_plan = UserPlans.get_user_plan!(id)

    with {:ok, %UserPlan{}} <- UserPlans.delete_user_plan(user_plan) do
      render(conn, "delete.json", status: "ok")
    end
  end
end
