defmodule App.PlanTransactions do
  @moduledoc """
  The PlanTransactions context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.PlanTransactions.PlanTransaction

  @doc """
  Returns the list of plans_transactions.

  ## Examples

      iex> list_plans_transactions()
      [%PlanTransaction{}, ...]

  """
  def list_plans_transactions do
    Repo.all(PlanTransaction)
  end

  @doc """
  Gets a single plan_transaction.

  Raises `Ecto.NoResultsError` if the Plan transaction does not exist.

  ## Examples

      iex> get_plan_transaction!(123)
      %PlanTransaction{}

      iex> get_plan_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plan_transaction!(id), do: Repo.get!(PlanTransaction, id)

  @doc """
  Creates a plan_transaction.

  ## Examples

      iex> create_plan_transaction(%{field: value})
      {:ok, %PlanTransaction{}}

      iex> create_plan_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plan_transaction(attrs \\ %{}) do
    %PlanTransaction{}
    |> PlanTransaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plan_transaction.

  ## Examples

      iex> update_plan_transaction(plan_transaction, %{field: new_value})
      {:ok, %PlanTransaction{}}

      iex> update_plan_transaction(plan_transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plan_transaction(%PlanTransaction{} = plan_transaction, attrs) do
    plan_transaction
    |> PlanTransaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plan_transaction.

  ## Examples

      iex> delete_plan_transaction(plan_transaction)
      {:ok, %PlanTransaction{}}

      iex> delete_plan_transaction(plan_transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plan_transaction(%PlanTransaction{} = plan_transaction) do
    Repo.delete(plan_transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plan_transaction changes.

  ## Examples

      iex> change_plan_transaction(plan_transaction)
      %Ecto.Changeset{source: %PlanTransaction{}}

  """
  def change_plan_transaction(%PlanTransaction{} = plan_transaction) do
    PlanTransaction.changeset(plan_transaction, %{})
  end

  @doc """
  Returns an last made transaction.

  ## Examples

      iex> last_made_plan_transaction(plan_transaction)
      %Ecto.Changeset{source: %PlanTransaction{}}

  """
  def last_made_plan_valid_transaction(%{"user_id" => user_id, "plan_id" => plan_id}) do
    query = from p in PlanTransaction, where: p.user_id == ^user_id, where: p.plan_id == ^plan_id, where: p.status == 1, order_by: [desc: p.updated_at], limit: 1

    Repo.one(query)
    # PlanTransaction |> where([u], u.user_id == ^user_id) |> where([u], u.plan_id == ^plan_id) |> limit(1) |> Repo.one
  end
end
