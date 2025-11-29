defmodule Ponos.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :naem, :string
    field :slug, :string
    field :logo_url, :string
    field :website, :string
    field :description, :string
    has_many :job_postings, Ponos.Jobs.JobPosting

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:naem, :slug, :logo_url, :website, :description])
    |> validate_required([:naem, :slug, :logo_url, :website, :description])
    |> unique_constraint(:slug)
  end
end
