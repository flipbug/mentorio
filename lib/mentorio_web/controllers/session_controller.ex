defmodule MentorioWeb.SessionController do
  use MentorioWeb, :controller

  alias Mentorio.Study
  alias Mentorio.Study.Session

  def index(conn, %{"iteration_id" => iteration_id}) do
    sessions = Study.list_sessions()
    render(conn, :index, sessions: sessions, iteration_id: iteration_id)
  end

  def new(conn, _params) do
    changeset = Study.change_session(%Session{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"session" => session_params, "iteration_id" => iteration_id}) do
    case Study.create_session(session_params) do
      {:ok, session} ->
        conn
        |> put_flash(:info, "Session created successfully.")
        |> redirect(to: ~p"/iterations/#{iteration_id}/sessions/#{session}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    session = Study.get_session!(id)
    render(conn, :show, session: session)
  end

  def edit(conn, %{"id" => id}) do
    session = Study.get_session!(id)
    changeset = Study.change_session(session)
    render(conn, :edit, session: session, changeset: changeset)
  end

  def update(conn, %{"id" => id, "session" => session_params, "iteration_id" => iteration_id}) do
    session = Study.get_session!(id)

    case Study.update_session(session, session_params) do
      {:ok, session} ->
        conn
        |> put_flash(:info, "Session updated successfully.")
        |> redirect(to: ~p"/iterations/#{iteration_id}/sessions/#{session}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, session: session, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "iteration_id" => iteration_id}) do
    session = Study.get_session!(id)
    {:ok, _session} = Study.delete_session(session)

    conn
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: ~p"/iterations/#{iteration_id}/sessions")
  end
end
