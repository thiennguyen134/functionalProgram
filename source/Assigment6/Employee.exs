defmodule Employee do
  use GenServer

  @enforce_keys [:first_name, :last_name]
  defstruct [
    :first_name,
    :last_name,
    id: nil,
    salary: 0,
    job: :none
  ]

  @job_levels %{
    none: 0,
    coder: 2000,
    designer: 4000,
    manager: 6000,
    ceo: 8000
  }


  def start_link(init_value \\ 0) do
    GenServer.start_link(__MODULE__, init_value, name: __MODULE__)
  end

  def new_employee(first_name, last_name) do
    id = GenServer.call(__MODULE__, :increment_id)
    %Employee{first_name: first_name, last_name: last_name, id: id}
  end

  def promote(%Employee{} = employee, new_job) do
    %{employee | job: new_job, salary: @job_levels[new_job]}
  end

  def demote(%Employee{} = employee, new_job) do
    %{employee | job: new_job, salary: @job_levels[new_job]}
  end



  def init(init_value) do
    {:ok, init_value}
  end

  def handle_call(:increment_id, _from, current_id) do
    {:reply, current_id, current_id + 1}
  end
end

{:ok, _} = Employee.start_link(1)

employee1 = Employee.new_employee("Alice", "Smith")
employee2 = Employee.new_employee("Bob", "Johnson")

employee1 = Employee.promote(employee1, :coder)
IO.inspect(employee1)


employee1 = Employee.demote(employee1, :none)
IO.inspect(employee1)

employee2 = Employee.promote(employee2, :manager)
IO.inspect(employee2)
