defmodule Ponos.JobsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ponos.Jobs` context.
  """

  @doc """
  Generate a job_posting.
  """
  def job_posting_fixture(attrs \\ %{}) do
    {:ok, job_posting} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        description_body: "some description_body",
        employment_type: "some employment_type",
        location: "some location",
        remote_type: "some remote_type",
        salary_max: 42,
        salary_min: 42,
        seniority_level: "some seniority_level",
        status: "some status",
        title: "some title"
      })
      |> Ponos.Jobs.create_job_posting()

    job_posting
  end
end
