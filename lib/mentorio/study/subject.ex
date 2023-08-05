defmodule Mentorio.Study.Subject do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subjects" do
    field :name, :string
    field :description, :string

    belongs_to :user, Mentorio.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :user_id])
  end
end
