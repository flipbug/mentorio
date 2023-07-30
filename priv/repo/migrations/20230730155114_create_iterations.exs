defmodule Mentorio.Repo.Migrations.CreateIterations do
  use Ecto.Migration

  def change do
    create table(:iterations) do
      add :theme, :string, null: false
      add :purpose, :string
      add :notes, :text
      add :start_date, :date
      add :end_date, :date
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:iterations, [:user_id])
  end
end
