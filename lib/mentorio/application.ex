defmodule Mentorio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MentorioWeb.Telemetry,
      # Start the Ecto repository
      Mentorio.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mentorio.PubSub},
      # Start Finch
      {Finch, name: Mentorio.Finch},
      # Start the Endpoint (http/https)
      MentorioWeb.Endpoint
      # Start a worker by calling: Mentorio.Worker.start_link(arg)
      # {Mentorio.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mentorio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MentorioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
