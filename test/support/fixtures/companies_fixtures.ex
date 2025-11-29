defmodule Ponos.CompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ponos.Companies` context.
  """

  @doc """
  Generate a unique company slug.
  """
  def unique_company_slug, do: "some slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        description: "some description",
        logo_url: "some logo_url",
        naem: "some naem",
        slug: unique_company_slug(),
        website: "some website"
      })
      |> Ponos.Companies.create_company()

    company
  end
end
