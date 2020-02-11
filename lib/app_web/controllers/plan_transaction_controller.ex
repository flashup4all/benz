defmodule AppWeb.PlanTransactionController do
  use AppWeb, :controller

  alias App.PlanTransactions
  alias App.Plans
  alias App.UserPlans
  alias App.PlanTransactions.PlanTransaction

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    plans_transactions = PlanTransactions.list_plans_transactions()
    render(conn, "index.json", plans_transactions: plans_transactions)
  end

  def create(conn, %{"plan_transaction" => plan_transaction_params}) do
    user_plan = UserPlans.get_user_plan!(plan_transaction_params["user_plan_id"])
    plan = Plans.get_plan!(user_plan.plan_id)
    plan_interest = plan.interest
    IO.puts "check status"
            IO.inspect PlanTransactions.last_made_plan_valid_transaction(plan_transaction_params)
    case PlanTransactions.last_made_plan_valid_transaction(plan_transaction_params) do
      nil ->
        calc = %{
          "previous_balance" => 0, 
          "current_balance" => plan_transaction_params["amount"],
          "current_interest_balance" => plan_transaction_params["amount"],
          "interest_rate" => plan_interest,
          "no_days" => 0
        }
        new_map = Map.merge(plan_transaction_params, calc)
        save(conn, new_map)

      last_transaction  ->
            IO.puts "exists balance"
            IO.inspect user_plan.status

        cond  do
          user_plan.status == 1 -> 
            IO.inspect plan

            days_diff = Date.diff(Date.utc_today(), last_transaction.updated_at);
            current_interest_balance = interest_type_calc(plan.interest_type, plan.interest, last_transaction.current_balance, days_diff, plan.duration)
            IO.puts "current balance"
            IO.inspect current_interest_balance
            current_balance = credit_or_debit(plan_transaction_params["trans_type"], current_interest_balance, plan_transaction_params["amount"])
            calc = %{
              "previous_balance" => last_transaction.current_balance, 
              "current_interest_balance" => current_interest_balance,
              "current_balance" => current_balance |> Float.floor(2),
              "interest_rate" => plan.interest,
              "no_days" => days_diff
            }
            IO.inspect calc
            new_map = Map.merge(plan_transaction_params, calc)
            save(conn, new_map)
          true -> 
            render(conn, "error.json", status: "error", msg: "plan not active")

          
            
        end
      
      end
        
    end
    
    def save(conn, params) do
      with {:ok, %PlanTransaction{} = plan_transaction} <- PlanTransactions.create_plan_transaction(params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.plan_transaction_path(conn, :show, plan_transaction))
        |> render("show.json", plan_transaction: plan_transaction)
    end
    
  end

  def show(conn, %{"id" => id}) do
    plan_transaction = PlanTransactions.get_plan_transaction!(id)
    render(conn, "show.json", plan_transaction: plan_transaction)
  end

  def update(conn, %{"id" => id, "plan_transaction" => plan_transaction_params}) do
    plan_transaction = PlanTransactions.get_plan_transaction!(id)

    with {:ok, %PlanTransaction{} = plan_transaction} <- PlanTransactions.update_plan_transaction(plan_transaction, plan_transaction_params) do
      render(conn, "show.json", plan_transaction: plan_transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    plan_transaction = PlanTransactions.get_plan_transaction!(id)

    with {:ok, %PlanTransaction{}} <- PlanTransactions.delete_plan_transaction(plan_transaction) do
      send_resp(conn, :no_content, "")
    end
  end

  def reducing_balance(interest, amount, days, duration) do
    interest_per_day = ((interest/100)/30) |> Float.floor(4) 
     total_interest = interest_per_day * amount
     total_balance = total_interest + amount
     total_balance 
     IO.inspect total_balance
     total_balance |> Float.floor(2)

    case days > 0 do
      true  -> reducing_balance(interest, total_balance, days-1, duration)
      false ->  amount
    end
  end

def total_add(value1, value2) do
  value1  + value2
end


  # def reducing_balance(interest, amount, days, duration) do
  #   interest_per_day = ((interest/100)/30) |> Float.floor(4) 
  #   IO.puts "++++ reducing balance"
  #   IO.inspect interest_per_day
  #   total_interest = interest_per_day * amount * days
  #   IO.puts "++++ reducing balance"
  #   IO.inspect total_interest
  #   total_balance = total_interest + amount
  #   IO.puts "++++ balance"
  #   IO.inspect total_balance
  # end

  def flat_rate(interest, amount, days, duration) do
    interest_per_day = (interest/100)/duration 
    total_interest = interest_per_day * amount * days
    total_balance = total_interest + amount
    total_balance |> Float.floor(2)
  end

  def perform_int_operation(plan, amount, days) do
    
  end

  def interest_type_calc(type, interest, amount, days, duration) when type == 1, do: flat_rate(interest, amount, days, duration)
  def interest_type_calc(type, interest, amount, days, duration) when type == 2, do: reducing_balance(interest, amount, days, duration)
  
  def credit_or_debit(type, balance, amount) do
    case type do
      1 ->
        balance + amount
      2 ->
        balance - amount
        
    end
  end
  
  
end
