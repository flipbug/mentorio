defmodule Mentorio.Repo.Migrations.CreateSubjects do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string, null: false
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:subjects, [:user_id])
  end
end
