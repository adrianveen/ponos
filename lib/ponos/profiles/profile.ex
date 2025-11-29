defmodule Ponos.Profiles.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :headline, :string
    field :about, :string
    field :location, :string
    field :experience_bullets, {:array, :map}
    field :project_bullets, {:array, :map}
    field :resume_url, :string
    field :user_id, :id
    many_to_many :skills, Ponos.Profiles.Skill, join_through: "profile_skills"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:headline, :about, :location, :experience_bullets, :project_bullets, :resume_url])
    |> validate_required([:headline, :about, :location, :experience_bullets, :project_bullets, :resume_url])
    |> unique_constraint(:user_id)
  end
end
