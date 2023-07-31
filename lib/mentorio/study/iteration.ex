defmodule Mentorio.Study.Iteration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "iterations" do
    field :theme, :string
    field :purpose, :string
    field :notes, :string
    field :start_date, :date
    field :end_date, :date
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(iteration, attrs) do
    iteration
    |> cast(attrs, [:theme, :purpose, :notes, :start_date, :end_date])
    |> validate_required([:theme, :purpose, :start_date, :end_date])
  end
end
