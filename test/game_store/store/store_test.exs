defmodule GameStore.StoreTest do
  use GameStore.DataCase

  alias GameStore.Store

  describe "games" do
    alias GameStore.Store.Game

    @valid_attrs %{description: "some description", name: "some name", url: "some url"}
    @update_attrs %{description: "some updated description", name: "some updated name", url: "some updated url"}
    @invalid_attrs %{description: nil, name: nil, url: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Store.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Store.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Store.create_game(@valid_attrs)
      assert game.description == "some description"
      assert game.name == "some name"
      assert game.url == "some url"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, game} = Store.update_game(game, @update_attrs)
      assert %Game{} = game
      assert game.description == "some updated description"
      assert game.name == "some updated name"
      assert game.url == "some updated url"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_game(game, @invalid_attrs)
      assert game == Store.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Store.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Store.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Store.change_game(game)
    end
  end
end
