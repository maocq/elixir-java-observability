defmodule ElixirObservability.Config.AppConfig do

  @moduledoc """
   Provides strcut for app-config
  """

   defstruct [
     :enable_server,
     :http_port,
     :external_service_ip
   ]

   def load_config do
     %__MODULE__{
       enable_server: load(:enable_server),
       http_port: load(:http_port),
       external_service_ip: load(:external_service_ip)
     }
   end

   defp load(property_name), do: Application.fetch_env!(:elixir_observability, property_name)
 end
