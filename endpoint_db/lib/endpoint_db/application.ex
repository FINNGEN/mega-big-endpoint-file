defmodule EndpointDB.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EndpointDBWeb.Telemetry,
      # Start the Ecto repository
      EndpointDB.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: EndpointDB.PubSub},
      # Start the Endpoint (http/https)
      EndpointDBWeb.Endpoint
      # Start a worker by calling: EndpointDB.Worker.start_link(arg)
      # {EndpointDB.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EndpointDB.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EndpointDBWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
