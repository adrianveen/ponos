defmodule Ponos.Accounts.AuthProvider do
  use Ecto.Schema
  import Ecto.Changeset

  schema "auth_providers" do
    field :provider, :string
    field :uid, :string
    field :token, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(auth_provider, attrs) do
    auth_provider
    |> cast(attrs, [:provider, :uid, :token])
    |> validate_required([:provider, :uid, :token])
  end
end
