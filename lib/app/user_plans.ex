defmodule App.UserPlans do
  @moduledoc """
  The UserPlans context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.UserPlans.UserPlan

  @doc """
  Returns the list of user_plans.

  ## Examples

      iex> list_user_plans()
      [%UserPlan{}, ...]

  """
  def list_user_plans(params) do
    UserPlan |> Repo.paginate(params)
  end

  @doc """
  Returns the list of user_plans belonging to a user.

  ## Examples

      iex> list_user_plans()
      [%UserPlan{}, ...]

  """
  def list_user_subscribed_plans(user_id, params) do
    UserPlan |> where(user_id: ^user_id) |> Repo.paginate(params)
  end

  @doc """
  Gets a single user_plan.

  Raises `Ecto.NoResultsError` if the User plan does not exist.

  ## Examples

      iex> get_user_plan!(123)
      %UserPlan{}

      iex> get_user_plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_plan!(id), do: Repo.get!(UserPlan, id)

  @doc """
  Creates a user_plan.

  ## Examples

      iex> create_user_plan(%{field: value})
      {:ok, %UserPlan{}}

      iex> create_user_plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_plan(attrs \\ %{}) do
       %UserPlan{}
        |> UserPlan.changeset(attrs)
        |> Repo.insert()
  end

  @doc """
  Updates a user_plan.

  ## Examples

      iex> update_user_plan(user_plan, %{field: new_value})
      {:ok, %UserPlan{}}

      iex> update_user_plan(user_plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_plan(%UserPlan{} = user_plan, attrs) do
    user_plan
    |> UserPlan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_plan.

  ## Examples

      iex> delete_user_plan(user_plan)
      {:ok, %UserPlan{}}

      iex> delete_user_plan(user_plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_plan(%UserPlan{} = user_plan) do
    Repo.delete(user_plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_plan changes.

  ## Examples

      iex> change_user_plan(user_plan)
      %Ecto.Changeset{source: %UserPlan{}}

  """
  def change_user_plan(%UserPlan{} = user_plan) do
    UserPlan.changeset(user_plan, %{})
  end

  @doc """
  checks if user already subscribe to plan

  ## Examples

      iex> check_if_user_already_subscribe()
      [%Plan{}, ...]

  """
  def check_if_user_already_subscribe(%{"user_id" => user_id, "plan_id" => plan_id}) do
    query = from p in UserPlan, where: p.user_id == ^user_id, where: p.plan_id == ^plan_id
    Repo.exists?(query)
  end
  
end
