defmodule Mentorio.Study do
  @moduledoc """
  The Study context.
  """

  import Ecto.Query, warn: false
  alias Mentorio.Repo

  alias Mentorio.Study.Iteration
  alias Mentorio.Study.Session

  @doc """
  Returns the list of iterations.

  ## Examples

      iex> list_iterations()
      [%Iteration{}, ...]

  """
  def list_iterations(user_id) when is_integer(user_id) do
    Repo.all(from i in Iteration, where: i.user_id == ^user_id)
  end

  @doc """
  Gets a single iteration.

  Raises `Ecto.NoResultsError` if the Iteration does not exist.

  ## Examples

      iex> get_iteration!(123)
      %Iteration{}

      iex> get_iteration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_iteration!(id),
    do:
      Repo.get!(Iteration, id)
      |> Repo.preload(sessions: from(s in Session, order_by: [desc: s.inserted_at]))
      |> Repo.preload(sessions: [:subject])

  @doc """
  Creates a iteration.

  ## Examples

      iex> create_iteration(%{field: value})
      {:ok, %Iteration{}}

      iex> create_iteration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_iteration(attrs \\ %{}) do
    %Iteration{}
    |> Iteration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a iteration.

  ## Examples

      iex> update_iteration(iteration, %{field: new_value})
      {:ok, %Iteration{}}

      iex> update_iteration(iteration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_iteration(%Iteration{} = iteration, attrs) do
    iteration
    |> Iteration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a iteration.

  ## Examples

      iex> delete_iteration(iteration)
      {:ok, %Iteration{}}

      iex> delete_iteration(iteration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_iteration(%Iteration{} = iteration) do
    Repo.delete(iteration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking iteration changes.

  ## Examples

      iex> change_iteration(iteration)
      %Ecto.Changeset{data: %Iteration{}}

  """
  def change_iteration(%Iteration{} = iteration, attrs \\ %{}) do
    Iteration.changeset(iteration, attrs)
  end

  def change_iteration_notes(%Iteration{} = iteration, attrs \\ %{}) do
    Iteration.changeset_notes(iteration, attrs)
  end

  def update_iteration_notes(%Iteration{} = iteration, attrs) do
    iteration
    |> Iteration.changeset_notes(attrs)
    |> Repo.update()
  end

  alias Mentorio.Study.Subject

  @doc """
  Returns the list of subjects.

  ## Examples

      iex> list_subjects()
      [%Subject{}, ...]

  """
  def list_subjects(user_id) when is_integer(user_id) do
    Repo.all(from i in Subject, where: i.user_id == ^user_id)
  end

  @doc """
  Gets a single subject.

  Raises `Ecto.NoResultsError` if the Subject does not exist.

  ## Examples

      iex> get_subject!(123)
      %Subject{}

      iex> get_subject!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subject!(id), do: Repo.get!(Subject, id)

  @doc """
  Creates a subject.

  ## Examples

      iex> create_subject(%{field: value})
      {:ok, %Subject{}}

      iex> create_subject(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subject(attrs \\ %{}) do
    %Subject{}
    |> Subject.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subject.

  ## Examples

      iex> update_subject(subject, %{field: new_value})
      {:ok, %Subject{}}

      iex> update_subject(subject, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subject(%Subject{} = subject, attrs) do
    subject
    |> Subject.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subject.

  ## Examples

      iex> delete_subject(subject)
      {:ok, %Subject{}}

      iex> delete_subject(subject)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subject(%Subject{} = subject) do
    Repo.delete(subject)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subject changes.

  ## Examples

      iex> change_subject(subject)
      %Ecto.Changeset{data: %Subject{}}

  """
  def change_subject(%Subject{} = subject, attrs \\ %{}) do
    Subject.changeset(subject, attrs)
  end

  alias Mentorio.Study.Session

  @doc """
  Returns the list of sessions.

  ## Examples

      iex> list_sessions()
      [%Session{}, ...]

  """
  def list_sessions do
    Repo.all(Session)
  end

  @doc """
  Gets a single session.

  Raises `Ecto.NoResultsError` if the Session does not exist.

  ## Examples

      iex> get_session!(123)
      %Session{}

      iex> get_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_session!(id), do: Repo.get!(Session, id)

  @doc """
  Creates a session.

  ## Examples

      iex> create_session(%{field: value})
      {:ok, %Session{}}

      iex> create_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_session(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a session.

  ## Examples

      iex> update_session(session, %{field: new_value})
      {:ok, %Session{}}

      iex> update_session(session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_session(%Session{} = session, attrs) do
    session
    |> Session.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a session.

  ## Examples

      iex> delete_session(session)
      {:ok, %Session{}}

      iex> delete_session(session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_session(%Session{} = session) do
    Repo.delete(session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking session changes.

  ## Examples

      iex> change_session(session)
      %Ecto.Changeset{data: %Session{}}

  """
  def change_session(%Session{} = session, attrs \\ %{}) do
    Session.changeset(session, attrs)
  end
end
