defmodule Ponos.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :full_name, :string
    field :is_recruiter, :boolean, default: false
    field :role_type, :string
    field :confirmed_at, :naive_datetime
    has_one :profile, Ponos.Profiles.Profile
    has_many :auth_providers, Ponos.Accounts.AuthProvider
    has_many :job_postings, Ponos.Jobs.JobPosting, foreign_key: :poster_user_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :full_name, :is_recruiter, :role_type, :confirmed_at])
    |> validate_required([:email, :full_name, :is_recruiter, :role_type, :confirmed_at])
    |> unique_constraint(:email)
  end
end
