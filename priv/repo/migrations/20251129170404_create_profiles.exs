defmodule Ponos.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :headline, :string
      add :about, :text
      add :location, :string
      add :experience_bullets, {:array, :map}
      add :project_bullets, {:array, :map}
      add :resume_url, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:profiles, [:user_id])
  end
end
