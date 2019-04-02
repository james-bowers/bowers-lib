defmodule ExBowers.FakeApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(
        scheme: :http,
        plug: ExBowers.FakeApp.Router,
        options: [port: 3084, protocol_options: [max_keepalive: 5_000_000]]
      )
    ]

    opts = [strategy: :one_for_one, name: Me.Router.Supervisor]
    Supervisor.start_link(children, opts)
  end
end