defmodule Ponos.Jobs.JobPosting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "job_postings" do
    field :title, :string
    field :status, :string
    field :seniority_level, :string
    field :employment_type, :string
    field :remote_type, :string
    field :location, :string
    field :salary_min, :integer
    field :salary_max, :integer
    field :currency, :string
    field :description_body, :string
    field :company_id, :id
    field :poster_user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(job_posting, attrs) do
    job_posting
    |> cast(attrs, [:title, :status, :seniority_level, :employment_type, :remote_type, :location, :salary_min, :salary_max, :currency, :description_body])
    |> validate_required([:title, :status, :seniority_level, :employment_type, :remote_type, :location, :salary_min, :salary_max, :currency, :description_body])
  end
end
