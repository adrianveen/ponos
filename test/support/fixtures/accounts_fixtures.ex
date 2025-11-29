defmodule Ponos.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ponos.Accounts` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        confirmed_at: ~N[2025-11-28 16:10:00],
        email: unique_user_email(),
        full_name: "some full_name",
        is_recruiter: true,
        role_type: "some role_type"
      })
      |> Ponos.Accounts.create_user()

    user
  end
end
