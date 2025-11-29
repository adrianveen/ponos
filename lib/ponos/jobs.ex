defmodule Ponos.Jobs do
  @moduledoc """
  The Jobs context.
  """

  import Ecto.Query, warn: false
  alias Ponos.Repo

  alias Ponos.Jobs.JobPosting

  @doc """
  Returns the list of job_postings.

  ## Examples

      iex> list_job_postings()
      [%JobPosting{}, ...]

  """
  def list_job_postings do
    Repo.all(JobPosting)
  end

  @doc """
  Gets a single job_posting.

  Raises `Ecto.NoResultsError` if the Job posting does not exist.

  ## Examples

      iex> get_job_posting!(123)
      %JobPosting{}

      iex> get_job_posting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_job_posting!(id), do: Repo.get!(JobPosting, id)

  @doc """
  Creates a job_posting.

  ## Examples

      iex> create_job_posting(%{field: value})
      {:ok, %JobPosting{}}

      iex> create_job_posting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_job_posting(attrs) do
    %JobPosting{}
    |> JobPosting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job_posting.

  ## Examples

      iex> update_job_posting(job_posting, %{field: new_value})
      {:ok, %JobPosting{}}

      iex> update_job_posting(job_posting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_job_posting(%JobPosting{} = job_posting, attrs) do
    job_posting
    |> JobPosting.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a job_posting.

  ## Examples

      iex> delete_job_posting(job_posting)
      {:ok, %JobPosting{}}

      iex> delete_job_posting(job_posting)
      {:error, %Ecto.Changeset{}}

  """
  def delete_job_posting(%JobPosting{} = job_posting) do
    Repo.delete(job_posting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job_posting changes.

  ## Examples

      iex> change_job_posting(job_posting)
      %Ecto.Changeset{data: %JobPosting{}}

  """
  def change_job_posting(%JobPosting{} = job_posting, attrs \\ %{}) do
    JobPosting.changeset(job_posting, attrs)
  end
end
