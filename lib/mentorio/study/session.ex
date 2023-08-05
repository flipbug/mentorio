defmodule Mentorio.Study.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :notes, :string
    belongs_to :subject, Mentorio.Study.Subject
    belongs_to :iteration, Mentorio.Study.Iteration

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:iteration_id, :subject_id, :notes])
    |> validate_required([:iteration_id, :subject_id])
  end
end
