defmodule ElixirObservability.Domain.UseCase.HelloUseCase do

  @account_behaviour Application.compile_env(:elixir_observability, :account_behaviour, ElixirObservability.Adapters.Repository.Account.AccountDataRepository)
  @external_service_behaviour Application.compile_env(:elixir_observability, :external_service_behaviour, ElixirObservability.Adapters.RestConsumer.RestConsumer)

  def external_service(status) do


    with {:ok, _} <- @external_service_behaviour.external_service(200),
         account  <- @account_behaviour.find_by_id(4000),
         {:ok, _} <- @external_service_behaviour.external_service(status) do

      updated_account = %{account | name: inspect(Timex.now)}
      {:ok, @account_behaviour.update(updated_account)}
    end
  end

  def external_service_latency(latency) do
    @external_service_behaviour.external_service_latency(latency)
  end
end
