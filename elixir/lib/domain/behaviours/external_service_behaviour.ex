defmodule ElixirObservability.Domain.Behaviours.ExternalServiceBehaviour do

  @callback external_service(term()) :: {:ok, String.t()} | {:error, term()}
end
