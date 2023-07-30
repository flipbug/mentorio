defmodule Mentorio.Study.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :notes, :string
    field :iteration_id, :id
    field :subject_id, :id

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:notes])
    |> validate_required([:notes])
  end
end
