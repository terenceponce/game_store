defmodule GameStore.Auth do
  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]

  alias GameStore.User
  alias GameStore.Repo

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end

  def login_by_email_and_password(conn, email, given_password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && checkpw(given_password, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw
        {:error, :not_found, conn}
    end
  end
end