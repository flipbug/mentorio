defmodule Mentorio.StudyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mentorio.Study` context.
  """

  @doc """
  Generate a iteration.
  """
  def iteration_fixture(attrs \\ %{}) do
    {:ok, iteration} =
      attrs
      |> Enum.into(%{
        name: "some name",
        theme: "some theme",
        purpose: "some purpose",
        notes: "some notes",
        start_date: ~D[2023-07-29],
        end_date: ~D[2023-07-29]
      })
      |> Mentorio.Study.create_iteration()

    iteration
  end

  @doc """
  Generate a subject.
  """
  def subject_fixture(attrs \\ %{}) do
    {:ok, subject} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description"
      })
      |> Mentorio.Study.create_subject()

    subject
  end

  @doc """
  Generate a session.
  """
  def session_fixture(attrs \\ %{}) do
    {:ok, session} =
      attrs
      |> Enum.into(%{
        notes: "some notes"
      })
      |> Mentorio.Study.create_session()

    session
  end
end
