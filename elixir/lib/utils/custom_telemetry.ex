defmodule ElixirObservability.Utils.CustomTelemetry do
  import Telemetry.Metrics

  def metrics(), do:
  [
    # VM
    last_value("vm.memory.total", unit: :byte),

    # Http Server
    counter("router_dispatch_stop_count", event_name: "plug.router_dispatch.stop", measurement: :duration,
       tags: [:route, :status], tag_values: &router_tags/1),
    sum("router_dispatch_stop_sum", event_name: "plug.router_dispatch.stop", measurement: :duration,
        tags: [:route, :status], tag_values: &router_tags/1),

    last_value("lamama", event_name: "plug.router_dispatch.stop", measurement: :duration,
        tags: [:route, :status], tag_values: &router_tags/1, unit: {:native, :millisecond}),

    counter("router_dispatch_exception_count", event_name: "plug.router_dispatch.exception", measurement: :duration, tags: [:route]),
    sum("router_dispatch_exception_sum", event_name: "plug.router_dispatch.exception", measurement: :duration, tags: [:route]),

    # Http client
    counter("finch_request_stop_count", event_name: "finch.request.stop", measurement: :duration,
      tags: [:host, :path, :status], tag_values: &finch_tags/1),
    sum("finch_request_stop_sum", event_name: "finch.request.stop", measurement: :duration,
      tags: [:host, :path, :status], tag_values: &finch_tags/1),

    # DB
    counter("repo_query_count", event_name: "elixir_observability.adapters.repository.repo.query", measurement: :total_time,
      tags: [:query]),
    sum("repo_query_sum", event_name: "elixir_observability.adapters.repository.repo.query", measurement: :total_time,
      tags: [:query])
  ]

  defp router_tags(%{route: route, conn: conn}),
    do: %{route: route, status: conn.status}

  defp finch_tags(%{request: request, result: result}) do
    status = case result do
      {:ok, response} -> response.status
      _ -> 0
    end

    %{host: request.host, path: request.path, status: status}
  end
end
