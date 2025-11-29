defmodule Ponos.Repo.Migrations.CreateJobPostings do
  use Ecto.Migration

  def change do
    create table(:job_postings) do
      add :title, :string
      add :status, :string
      add :seniority_level, :string
      add :employment_type, :string
      add :remote_type, :string
      add :location, :string
      add :salary_min, :integer
      add :salary_max, :integer
      add :currency, :string
      add :description_body, :text
      add :company_id, references(:companies, on_delete: :nothing)
      add :poster_user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:job_postings, [:company_id])
    create index(:job_postings, [:poster_user_id])
  end
end
