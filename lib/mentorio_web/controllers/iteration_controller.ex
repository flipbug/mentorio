defmodule MentorioWeb.IterationController do
  use MentorioWeb, :controller

  alias Mentorio.Study
  alias Mentorio.Study.Iteration

  def index(conn, _params) do
    iterations = Study.list_iterations()
    render(conn, :index, iterations: iterations)
  end

  def new(conn, _params) do
    changeset = Study.change_iteration(%Iteration{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"iteration" => iteration_params}) do
    case Study.create_iteration(iteration_params) do
      {:ok, iteration} ->
        conn
        |> put_flash(:info, "Iteration created successfully.")
        |> redirect(to: ~p"/iterations/#{iteration}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    iteration = Study.get_iteration!(id)
    render(conn, :show, iteration: iteration)
  end

  def edit(conn, %{"id" => id}) do
    iteration = Study.get_iteration!(id)
    changeset = Study.change_iteration(iteration)
    render(conn, :edit, iteration: iteration, changeset: changeset)
  end

  def update(conn, %{"id" => id, "iteration" => iteration_params}) do
    iteration = Study.get_iteration!(id)

    case Study.update_iteration(iteration, iteration_params) do
      {:ok, iteration} ->
        conn
        |> put_flash(:info, "Iteration updated successfully.")
        |> redirect(to: ~p"/iterations/#{iteration}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, iteration: iteration, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    iteration = Study.get_iteration!(id)
    {:ok, _iteration} = Study.delete_iteration(iteration)

    conn
    |> put_flash(:info, "Iteration deleted successfully.")
    |> redirect(to: ~p"/iterations")
  end
end
