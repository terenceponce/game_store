# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :game_store,
  ecto_repos: [GameStore.Repo]

# Configures the endpoint
config :game_store, GameStoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "C7LQELPhVKPRDrKV1KkY+7lRsSRv3T3tUV20E6e04PvNDvisFTysDe25nD7mKiC8",
  render_errors: [view: GameStoreWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GameStore.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "GameStore.#{Mix.env}",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: to_string(Mix.env) <> "lg8jQirtKYtU00v359MqFsU",
  serializer: GameStore.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
