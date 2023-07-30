defmodule Mentorio.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :notes, :text
      add :iteration_id, references(:iterations, on_delete: :nothing)
      add :subject_id, references(:subjects, on_delete: :nothing)

      timestamps()
    end

    create index(:sessions, [:iteration_id])
    create index(:sessions, [:subject_id])
  end
end
