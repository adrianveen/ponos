defmodule Ponos.ProfilesTest do
  use Ponos.DataCase

  alias Ponos.Profiles

  describe "profiles" do
    alias Ponos.Profiles.Profile

    import Ponos.ProfilesFixtures

    @invalid_attrs %{location: nil, headline: nil, about: nil, experience_bullets: nil, project_bullets: nil, resume_url: nil}

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Profiles.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Profiles.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      valid_attrs = %{location: "some location", headline: "some headline", about: "some about", experience_bullets: [], project_bullets: [], resume_url: "some resume_url"}

      assert {:ok, %Profile{} = profile} = Profiles.create_profile(valid_attrs)
      assert profile.location == "some location"
      assert profile.headline == "some headline"
      assert profile.about == "some about"
      assert profile.experience_bullets == []
      assert profile.project_bullets == []
      assert profile.resume_url == "some resume_url"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      update_attrs = %{location: "some updated location", headline: "some updated headline", about: "some updated about", experience_bullets: [], project_bullets: [], resume_url: "some updated resume_url"}

      assert {:ok, %Profile{} = profile} = Profiles.update_profile(profile, update_attrs)
      assert profile.location == "some updated location"
      assert profile.headline == "some updated headline"
      assert profile.about == "some updated about"
      assert profile.experience_bullets == []
      assert profile.project_bullets == []
      assert profile.resume_url == "some updated resume_url"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_profile(profile, @invalid_attrs)
      assert profile == Profiles.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Profiles.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Profiles.change_profile(profile)
    end
  end
end
