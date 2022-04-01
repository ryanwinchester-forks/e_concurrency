defmodule EConcurrency.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: EConcurrency, options: [port: 4000]}
    ]

    Logger.info("[Application] Starting EConcurrency on http://localhost:4000")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EConcurrency.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
