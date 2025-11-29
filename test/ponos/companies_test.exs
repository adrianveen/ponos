defmodule Ponos.CompaniesTest do
  use Ponos.DataCase

  alias Ponos.Companies

  describe "companies" do
    alias Ponos.Companies.Company

    import Ponos.CompaniesFixtures

    @invalid_attrs %{description: nil, naem: nil, slug: nil, logo_url: nil, website: nil}

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      valid_attrs = %{description: "some description", naem: "some naem", slug: "some slug", logo_url: "some logo_url", website: "some website"}

      assert {:ok, %Company{} = company} = Companies.create_company(valid_attrs)
      assert company.description == "some description"
      assert company.naem == "some naem"
      assert company.slug == "some slug"
      assert company.logo_url == "some logo_url"
      assert company.website == "some website"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      update_attrs = %{description: "some updated description", naem: "some updated naem", slug: "some updated slug", logo_url: "some updated logo_url", website: "some updated website"}

      assert {:ok, %Company{} = company} = Companies.update_company(company, update_attrs)
      assert company.description == "some updated description"
      assert company.naem == "some updated naem"
      assert company.slug == "some updated slug"
      assert company.logo_url == "some updated logo_url"
      assert company.website == "some updated website"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)
      assert company == Companies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end
end
