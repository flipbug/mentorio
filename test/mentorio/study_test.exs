defmodule Mentorio.StudyTest do
  use Mentorio.DataCase

  alias Mentorio.Study

  describe "iterations" do
    alias Mentorio.Study.Iteration

    import Mentorio.StudyFixtures

    @invalid_attrs %{name: nil, theme: nil, purpose: nil, notes: nil, start_date: nil, end_date: nil}

    test "list_iterations/0 returns all iterations" do
      iteration = iteration_fixture()
      assert Study.list_iterations() == [iteration]
    end

    test "get_iteration!/1 returns the iteration with given id" do
      iteration = iteration_fixture()
      assert Study.get_iteration!(iteration.id) == iteration
    end

    test "create_iteration/1 with valid data creates a iteration" do
      valid_attrs = %{name: "some name", theme: "some theme", purpose: "some purpose", notes: "some notes", start_date: ~D[2023-07-29], end_date: ~D[2023-07-29]}

      assert {:ok, %Iteration{} = iteration} = Study.create_iteration(valid_attrs)
      assert iteration.name == "some name"
      assert iteration.theme == "some theme"
      assert iteration.purpose == "some purpose"
      assert iteration.notes == "some notes"
      assert iteration.start_date == ~D[2023-07-29]
      assert iteration.end_date == ~D[2023-07-29]
    end

    test "create_iteration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Study.create_iteration(@invalid_attrs)
    end

    test "update_iteration/2 with valid data updates the iteration" do
      iteration = iteration_fixture()
      update_attrs = %{name: "some updated name", theme: "some updated theme", purpose: "some updated purpose", notes: "some updated notes", start_date: ~D[2023-07-30], end_date: ~D[2023-07-30]}

      assert {:ok, %Iteration{} = iteration} = Study.update_iteration(iteration, update_attrs)
      assert iteration.name == "some updated name"
      assert iteration.theme == "some updated theme"
      assert iteration.purpose == "some updated purpose"
      assert iteration.notes == "some updated notes"
      assert iteration.start_date == ~D[2023-07-30]
      assert iteration.end_date == ~D[2023-07-30]
    end

    test "update_iteration/2 with invalid data returns error changeset" do
      iteration = iteration_fixture()
      assert {:error, %Ecto.Changeset{}} = Study.update_iteration(iteration, @invalid_attrs)
      assert iteration == Study.get_iteration!(iteration.id)
    end

    test "delete_iteration/1 deletes the iteration" do
      iteration = iteration_fixture()
      assert {:ok, %Iteration{}} = Study.delete_iteration(iteration)
      assert_raise Ecto.NoResultsError, fn -> Study.get_iteration!(iteration.id) end
    end

    test "change_iteration/1 returns a iteration changeset" do
      iteration = iteration_fixture()
      assert %Ecto.Changeset{} = Study.change_iteration(iteration)
    end
  end

  describe "subjects" do
    alias Mentorio.Study.Subject

    import Mentorio.StudyFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_subjects/0 returns all subjects" do
      subject = subject_fixture()
      assert Study.list_subjects() == [subject]
    end

    test "get_subject!/1 returns the subject with given id" do
      subject = subject_fixture()
      assert Study.get_subject!(subject.id) == subject
    end

    test "create_subject/1 with valid data creates a subject" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Subject{} = subject} = Study.create_subject(valid_attrs)
      assert subject.name == "some name"
      assert subject.description == "some description"
    end

    test "create_subject/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Study.create_subject(@invalid_attrs)
    end

    test "update_subject/2 with valid data updates the subject" do
      subject = subject_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Subject{} = subject} = Study.update_subject(subject, update_attrs)
      assert subject.name == "some updated name"
      assert subject.description == "some updated description"
    end

    test "update_subject/2 with invalid data returns error changeset" do
      subject = subject_fixture()
      assert {:error, %Ecto.Changeset{}} = Study.update_subject(subject, @invalid_attrs)
      assert subject == Study.get_subject!(subject.id)
    end

    test "delete_subject/1 deletes the subject" do
      subject = subject_fixture()
      assert {:ok, %Subject{}} = Study.delete_subject(subject)
      assert_raise Ecto.NoResultsError, fn -> Study.get_subject!(subject.id) end
    end

    test "change_subject/1 returns a subject changeset" do
      subject = subject_fixture()
      assert %Ecto.Changeset{} = Study.change_subject(subject)
    end
  end

  describe "sessions" do
    alias Mentorio.Study.Session

    import Mentorio.StudyFixtures

    @invalid_attrs %{notes: nil}

    test "list_sessions/0 returns all sessions" do
      session = session_fixture()
      assert Study.list_sessions() == [session]
    end

    test "get_session!/1 returns the session with given id" do
      session = session_fixture()
      assert Study.get_session!(session.id) == session
    end

    test "create_session/1 with valid data creates a session" do
      valid_attrs = %{notes: "some notes"}

      assert {:ok, %Session{} = session} = Study.create_session(valid_attrs)
      assert session.notes == "some notes"
    end

    test "create_session/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Study.create_session(@invalid_attrs)
    end

    test "update_session/2 with valid data updates the session" do
      session = session_fixture()
      update_attrs = %{notes: "some updated notes"}

      assert {:ok, %Session{} = session} = Study.update_session(session, update_attrs)
      assert session.notes == "some updated notes"
    end

    test "update_session/2 with invalid data returns error changeset" do
      session = session_fixture()
      assert {:error, %Ecto.Changeset{}} = Study.update_session(session, @invalid_attrs)
      assert session == Study.get_session!(session.id)
    end

    test "delete_session/1 deletes the session" do
      session = session_fixture()
      assert {:ok, %Session{}} = Study.delete_session(session)
      assert_raise Ecto.NoResultsError, fn -> Study.get_session!(session.id) end
    end

    test "change_session/1 returns a session changeset" do
      session = session_fixture()
      assert %Ecto.Changeset{} = Study.change_session(session)
    end
  end
end
