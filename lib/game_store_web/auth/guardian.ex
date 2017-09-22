defmodule GameStore.Guardian do
  use Guardian, otp_app: :game_store

  alias GameStore.Repo
  alias GameStore.User

  def subject_for_token(user = %User{}, _claims) do
    {:ok, "#{user.id}"}
  end

  def subject_for_token(_, _) do
    {:error, "Unknown resource type"}
  end

  def resource_from_claims(claims) do
    {:ok, Repo.get(User, claims["id"])}
  end

  def resource_from_claims(_claims) do
    {:error, "Unknown resource type"}
  end
end