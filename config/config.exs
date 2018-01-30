# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :webpager,
  namespace: WePager,
  ecto_repos: [WePager.Repo]

# Configures the endpoint
config :webpager, WePagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NafLJ57U3g/uvneFLaKO0LgtoZz/b7UdL/++wAn4SIG+XJCIFFppbO1BKrmIXRgY",
  render_errors: [view: WePagerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: WePager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
