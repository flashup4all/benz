defmodule AppWeb.PlanView do
  use AppWeb, :view
  alias AppWeb.PlanView

  def render("index.json", %{plans: plans, paginator: page}) do
    %{
      data: render_many(plans, PlanView, "plan.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{plan: plan}) do
    %{data: render_one(plan, PlanView, "plan.json")}
  end

  def render("plan.json", %{plan: plan}) do
    %{
      id: plan.id,
      user_id: plan.user_id,
      name: plan.name,
      type: plan.type,
      interest_type: plan.interest_type,
      description: plan.description,
      minimum_amount: plan.minimum_amount,
      interest: plan.interest,
      company_interest: plan.company_interest,
      partner_interest: plan.partner_interest,
      interest_apply_type: plan.interest_apply_type,
      is_admin: plan.is_admin,
      status: plan.status,
      crowdfunding: plan.crowdfunding,
      image: plan.image,
      inserted_at: plan.inserted_at,
      updated_at: plan.updated_at,
      duration: plan.duration
    }
  end
  def render("delete.json", %{status: status}) do
    %{status: status, msg: "data deleted"}
  end
end
