defmodule Ponos.JobsTest do
  use Ponos.DataCase

  alias Ponos.Jobs

  describe "job_postings" do
    alias Ponos.Jobs.JobPosting

    import Ponos.JobsFixtures

    @invalid_attrs %{status: nil, title: nil, location: nil, remote_type: nil, currency: nil, seniority_level: nil, employment_type: nil, salary_min: nil, salary_max: nil, description_body: nil}

    test "list_job_postings/0 returns all job_postings" do
      job_posting = job_posting_fixture()
      assert Jobs.list_job_postings() == [job_posting]
    end

    test "get_job_posting!/1 returns the job_posting with given id" do
      job_posting = job_posting_fixture()
      assert Jobs.get_job_posting!(job_posting.id) == job_posting
    end

    test "create_job_posting/1 with valid data creates a job_posting" do
      valid_attrs = %{status: "some status", title: "some title", location: "some location", remote_type: "some remote_type", currency: "some currency", seniority_level: "some seniority_level", employment_type: "some employment_type", salary_min: 42, salary_max: 42, description_body: "some description_body"}

      assert {:ok, %JobPosting{} = job_posting} = Jobs.create_job_posting(valid_attrs)
      assert job_posting.status == "some status"
      assert job_posting.title == "some title"
      assert job_posting.location == "some location"
      assert job_posting.remote_type == "some remote_type"
      assert job_posting.currency == "some currency"
      assert job_posting.seniority_level == "some seniority_level"
      assert job_posting.employment_type == "some employment_type"
      assert job_posting.salary_min == 42
      assert job_posting.salary_max == 42
      assert job_posting.description_body == "some description_body"
    end

    test "create_job_posting/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jobs.create_job_posting(@invalid_attrs)
    end

    test "update_job_posting/2 with valid data updates the job_posting" do
      job_posting = job_posting_fixture()
      update_attrs = %{status: "some updated status", title: "some updated title", location: "some updated location", remote_type: "some updated remote_type", currency: "some updated currency", seniority_level: "some updated seniority_level", employment_type: "some updated employment_type", salary_min: 43, salary_max: 43, description_body: "some updated description_body"}

      assert {:ok, %JobPosting{} = job_posting} = Jobs.update_job_posting(job_posting, update_attrs)
      assert job_posting.status == "some updated status"
      assert job_posting.title == "some updated title"
      assert job_posting.location == "some updated location"
      assert job_posting.remote_type == "some updated remote_type"
      assert job_posting.currency == "some updated currency"
      assert job_posting.seniority_level == "some updated seniority_level"
      assert job_posting.employment_type == "some updated employment_type"
      assert job_posting.salary_min == 43
      assert job_posting.salary_max == 43
      assert job_posting.description_body == "some updated description_body"
    end

    test "update_job_posting/2 with invalid data returns error changeset" do
      job_posting = job_posting_fixture()
      assert {:error, %Ecto.Changeset{}} = Jobs.update_job_posting(job_posting, @invalid_attrs)
      assert job_posting == Jobs.get_job_posting!(job_posting.id)
    end

    test "delete_job_posting/1 deletes the job_posting" do
      job_posting = job_posting_fixture()
      assert {:ok, %JobPosting{}} = Jobs.delete_job_posting(job_posting)
      assert_raise Ecto.NoResultsError, fn -> Jobs.get_job_posting!(job_posting.id) end
    end

    test "change_job_posting/1 returns a job_posting changeset" do
      job_posting = job_posting_fixture()
      assert %Ecto.Changeset{} = Jobs.change_job_posting(job_posting)
    end
  end
end
