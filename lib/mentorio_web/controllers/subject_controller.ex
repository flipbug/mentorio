defmodule MentorioWeb.SubjectController do
  use MentorioWeb, :controller

  alias Mentorio.Study
  alias Mentorio.Study.Subject

  def index(conn, _params) do
    subjects = Study.list_subjects()
    render(conn, :index, subjects: subjects)
  end

  def new(conn, _params) do
    changeset = Study.change_subject(%Subject{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"subject" => subject_params}) do
    case Study.create_subject(subject_params) do
      {:ok, subject} ->
        conn
        |> put_flash(:info, "Subject created successfully.")
        |> redirect(to: ~p"/subjects/#{subject}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subject = Study.get_subject!(id)
    render(conn, :show, subject: subject)
  end

  def edit(conn, %{"id" => id}) do
    subject = Study.get_subject!(id)
    changeset = Study.change_subject(subject)
    render(conn, :edit, subject: subject, changeset: changeset)
  end

  def update(conn, %{"id" => id, "subject" => subject_params}) do
    subject = Study.get_subject!(id)

    case Study.update_subject(subject, subject_params) do
      {:ok, subject} ->
        conn
        |> put_flash(:info, "Subject updated successfully.")
        |> redirect(to: ~p"/subjects/#{subject}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, subject: subject, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subject = Study.get_subject!(id)
    {:ok, _subject} = Study.delete_subject(subject)

    conn
    |> put_flash(:info, "Subject deleted successfully.")
    |> redirect(to: ~p"/subjects")
  end
end
