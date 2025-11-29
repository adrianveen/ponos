defmodule Ponos.Repo.Migrations.CreateAuthProviders do
  use Ecto.Migration

  def change do
    create table(:auth_providers) do
      add :provider, :string
      add :uid, :string
      add :token, :text
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:auth_providers, [:user_id])
    create unique_index(:auth_providers, [:provider, :uid])
  end
end
