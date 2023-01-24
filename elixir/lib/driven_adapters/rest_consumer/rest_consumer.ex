defmodule ElixirObservability.Adapters.RestConsumer.RestConsumer do
  alias ElixirObservability.Config.ConfigHolder

  @behaviour ElixirObservability.Domain.Behaviours.ExternalServiceBehaviour

  def external_service(status) do
    %{ external_service_ip: external_service_ip } = ConfigHolder.conf()
    url = "http://#{external_service_ip}:8080/api/usecase/account?status=#{status}"

    headers = :otel_propagator_text_map.inject([])
    with  request <- Finch.build(:get, url, headers),
            {:ok, response} <- Finch.request(request, HttpFinch),
            %Finch.Response{status: status, body: body} <- response do

        if status != 200, do: {:error, "Error external service"}, else: {:ok, body}
    end
  end

  def external_service_latency(latency) do
    %{ external_service_ip: external_service_ip } = ConfigHolder.conf()
    url = "http://#{external_service_ip}:8080/api/usecase/latency?delay=#{latency}"

    case Finch.build(:get, url) |> Finch.request(HttpFinch) do
      {:ok, %Finch.Response{body: body}} -> {:ok, body}
      error -> error
    end
  end
end
