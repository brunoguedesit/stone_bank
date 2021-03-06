# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stone_bank, StoneBank.Accounts.Auth.Guardian,
  issuer: "stone_bank",
  secret_key: "zn8BUXbpx1/pojZtWOPjexNPcgzb4tt2T7POWoJPctQ8/PruizveqORpTVCYDtD7"

config :ex_money,
  auto_start_exchange_rate_service: true,
  open_exchange_rates_app_id: "b609b494ff204b5f8e8e708454b3ea58",
  exchange_rates_retrieve_every: :never,
  api_module: Money.ExchangeRates.OpenExchangeRates,
  callback_module: Money.ExchangeRates.Callback,
  exchange_rates_cache_module: Money.ExchangeRates.Cache.Ets,
  preload_historic_rates: nil,
  retriever_options: nil,
  log_failure: :warn,
  log_info: :info,
  log_success: nil,
  json_library: Jason,
  default_cldr_backend: StoneBank.Cldr

config :ex_cldr,
  json_library: Jason

config :stone_bank,
  ecto_repos: [StoneBank.Repo]

# Configures the endpoint
config :stone_bank, StoneBankWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DE8H7AJnGOml3Qwl6aZNGxwp45dtnM2fIFtN9hgEm/0yN7xbNYtLc0MfyBK1MvRE",
  render_errors: [view: StoneBankWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: StoneBank.PubSub,
  live_view: [signing_salt: "0m78oPaI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

if Mix.env() == :test do
  config :junit_formatter,
    report_dir: "/tmp/stone-bank-test-results/exunit/"
end

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
