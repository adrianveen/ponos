defmodule Ponos.Repo.Migrations.CreateProfileSkills do
  use Ecto.Migration

  def change do
    create table(:profile_skills) do
      add :profile_id, references(:profiles, on_delete: :nothing)
      add :skill_id, references(:skills, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:profile_skills, [:profile_id])
    create index(:profile_skills, [:skill_id])
    create unique_index(:profile_skills, [:profile_id, :skill_id])
  end
end
