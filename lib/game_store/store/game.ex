defmodule GameStore.Store.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias GameStore.Store.Game


  schema "games" do
    field :description, :string
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:name, :description, :url])
    |> validate_required([:name, :description, :url])
  end
end
