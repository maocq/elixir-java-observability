defmodule ElixirObservability.EntryPoint.ApiRest do
  @moduledoc """
  Access point to the rest exposed services
  """
  require OpenTelemetry.Tracer, as: Tracer
  alias ElixirObservability.Domain.UseCase.HelloUseCase

  require Logger
  use Plug.Router
  use Plug.ErrorHandler
  use Timex

  plug(CORSPlug,
    methods: ["GET", "POST", "PUT", "DELETE"],
    origin: [~r/.*/],
    headers: ["Content-Type", "Accept", "User-Agent"]
  )

  plug(Plug.Logger, log: :debug)
  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison)
  plug(Plug.Telemetry, event_prefix: [:elixir_observability, :plug])
  plug(:dispatch)

  forward(
    "/app/api/health",
    to: PlugCheckup,
    init_opts: PlugCheckup.Options.new(json_encoder: Jason, checks: ElixirObservability.EntryPoint.HealthCheck.checks)
  )

  get "/app/api/hello" do
    build_response("Hello World", conn)
  end

  get "/app/api/usecase" do
    status = conn.query_params["status"] || "200"

    case HelloUseCase.external_service(status) do
      {:ok, response} -> response |> build_response(conn)
      {:error, error} ->
        Logger.error("Error use case #{inspect(error)}")
        Tracer.set_status(:error, inspect(error))

        build_response(%{status: 500, body: "Error"}, conn)
    end
  end

  get "/app/api/latency" do
    delay = conn.query_params["delay"] || 0

    case HelloUseCase.external_service_latency(delay) do
      {:ok, response} -> response |> build_response(conn)
      {:error, error} ->
        Logger.error("Error latency #{inspect(error)}")
        build_response(%{status: 500, body: "Error"}, conn)
    end
  end

  match _ do
    %{request_path: path} = conn
    build_response(%{status: 404, body: %{status: 404, path: path}}, conn)
  end

  def build_response(%{status: status, body: body}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(body))
  end

  def build_response(response, conn), do: build_response(%{status: 200, body: response}, conn)

  @impl Plug.ErrorHandler
  def handle_errors(conn, error) do
    Logger.error("Internal server - #{inspect(error)}")
    Tracer.set_status(:error, inspect(error))

    build_response(%{status: 500, body: %{status: 500, error: "Internal server"}}, conn)
  end
end
