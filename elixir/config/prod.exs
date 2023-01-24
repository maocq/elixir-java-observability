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
       level: :debug

config :logger,
       backends: [{LoggerFileBackend, :debug_log}]

config :logger, :debug_log,
       path: "/tmp/log/observability-elixir.log",
       level: :debug

config :elixir_observability, ElixirObservability.Adapters.Repository.Repo,
       database: "compose-postgres",
       username: "compose-postgres",
       password: "compose-postgres",
       hostname: "observability-db",
       pool_size: 10,
       queue_target: 5000,
       timeout: :timer.minutes(1)

config :elixir_observability,
       external_service_ip: "observability-java"

config :elixir_observability,
       account_behaviour: ElixirObservability.Adapters.Repository.Account.AccountDataRepository,
       external_service_behaviour: ElixirObservability.Adapters.RestConsumer.RestConsumer
