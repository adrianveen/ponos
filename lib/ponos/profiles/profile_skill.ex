defmodule Ponos.Profiles.ProfileSkill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profile_skills" do

    field :profile_id, :id
    field :skill_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(profile_skill, attrs) do
    profile_skill
    |> cast(attrs, [])
    |> validate_required([])
  end
end
