defmodule AppWeb.UserPlanView do
  use AppWeb, :view
  alias AppWeb.UserPlanView

  def render("index.json", %{user_plans: user_plans, paginator: page}) do
    %{
      data: render_many(user_plans, UserPlanView, "user_plan.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{user_plan: user_plan}) do
    %{data: render_one(user_plan, UserPlanView, "user_plan.json")}
  end

  def render("user_plan.json", %{user_plan: user_plan}) do
    %{
      id: user_plan.id,
      user_id: user_plan.user_id,
      plan_id: user_plan.plan_id,
      status: user_plan.status
    }
  end

  def render("error.json", %{status: status, msg: msg}) do
    %{status: status, msg: msg}
  end
  def render("delete.json", %{status: status}) do
    %{status: status, msg: "data destroyed"}
  end
end
