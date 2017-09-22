defmodule GameStore.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :description, :string
      add :url, :string

      timestamps()
    end

  end
end
