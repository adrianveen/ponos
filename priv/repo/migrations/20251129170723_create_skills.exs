defmodule Ponos.Repo.Migrations.CreateSkills do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add :name, :string
      add :category, :string
      add :is_canonical, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:skills, [:name])
  end
end
