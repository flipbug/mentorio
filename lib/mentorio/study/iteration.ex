defmodule Mentorio.Study.Iteration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "iterations" do
    field :theme, :string
    field :purpose, :string
    field :notes, :string
    field :start_date, :date
    field :end_date, :date

    belongs_to :user, Mentorio.Accounts.User
    has_many :sessions, Mentorio.Study.Session

    timestamps()
  end

  @doc false
  def changeset(iteration, attrs) do
    iteration
    |> cast(attrs, [:theme, :purpose, :notes, :start_date, :end_date, :user_id])
    |> validate_required([:theme, :purpose, :start_date, :end_date, :user_id])
  end

  def changeset_notes(iteration, attrs) do
    iteration
    |> cast(attrs, [:notes])
  end
end
