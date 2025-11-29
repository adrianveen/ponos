defmodule Ponos.Profiles.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "skills" do
    field :name, :string
    field :category, :string
    field :is_canonical, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [:name, :category, :is_canonical])
    |> validate_required([:name, :category, :is_canonical])
    |> unique_constraint(:name)
  end
end
