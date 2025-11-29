defmodule Ponos.ProfilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ponos.Profiles` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        about: "some about",
        experience_bullets: [],
        headline: "some headline",
        location: "some location",
        project_bullets: [],
        resume_url: "some resume_url"
      })
      |> Ponos.Profiles.create_profile()

    profile
  end
end
