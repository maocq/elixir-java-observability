import Config

config :elixir_observability, timezone: "America/Bogota"

config :elixir_observability,
       http_port: 8083,
       enable_server: true,
       secret_name: "",
       region: "",
       version: "0.0.1",
       in_test: false,
       custom_metrics_prefix_name: "elixir_observability_local"

config :logger,
       level: :info

config :elixir_observability, ElixirObservability.Adapters.Repository.Repo,
       database: "compose-postgres",
       username: "compose-postgres",
       password: "compose-postgres",
       hostname: "172.17.0.1", # "observability-db"
       pool_size: 10,
       queue_target: 5000,
       timeout: :timer.minutes(1)

config :elixir_observability,
       external_service_ip: "172.17.0.1"

config :elixir_observability,
       account_behaviour: ElixirObservability.Adapters.Repository.Account.AccountDataRepository,
       external_service_behaviour: ElixirObservability.Adapters.RestConsumer.RestConsumer
