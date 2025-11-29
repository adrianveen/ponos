defmodule Ponos.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :naem, :string
      add :slug, :string
      add :logo_url, :string
      add :website, :string
      add :description, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:companies, [:slug])
  end
end
