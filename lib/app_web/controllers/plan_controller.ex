defmodule AppWeb.PlanController do
  use AppWeb, :controller

  alias App.Plans
  alias App.Plans.Plan

  action_fallback AppWeb.FallbackController

  def index(conn, params) do
    page = Plans.list_plans(params)
   
    paginator = %{
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }

    render(conn, "index.json", plans: page.entries, paginator: paginator)
  end

  def user_plans(conn,  %{"id" => id} = params) do
    page = Plans.user_plans(id, params)
    paginator = %{
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
    

    render(conn, "index.json", plans: page.entries, paginator: paginator)
  end

  def create(conn, %{"plan" => plan_params}) do
    with {:ok, %Plan{} = plan} <- Plans.create_plan(plan_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.plan_path(conn, :show, plan))
      |> render("show.json", plan: plan)
    end
  end

  def show(conn, %{"id" => id}) do
    plan = Plans.get_plan!(id)
    render(conn, "show.json", plan: plan)
  end

  def update(conn, %{"id" => id, "plan" => plan_params}) do
    plan = Plans.get_plan!(id)

    with {:ok, %Plan{} = plan} <- Plans.update_plan(plan, plan_params) do
      render(conn, "show.json", plan: plan)
    end
  end

  def delete(conn, %{"id" => id}) do
    plan = Plans.get_plan!(id)

    with {:ok, %Plan{}} <- Plans.delete_plan(plan) do
      render(conn, "delete.json", status: "data destroyed")
    end
  end
end
