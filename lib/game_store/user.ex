defmodule GameStore.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias GameStore.User

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :is_admin, :boolean

    timestamps()
  end

  @required_fields ~w(email)a
  @optional_fields ~w(is_admin)a

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_length(:password, min: 6, max: 30)
    |> hash_password
  end

  def hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset,
                   :password_hash,
                   Comeonin.Argon2.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
