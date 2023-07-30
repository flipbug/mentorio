defmodule Mentorio.Study.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :name, :string
    field :description, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
