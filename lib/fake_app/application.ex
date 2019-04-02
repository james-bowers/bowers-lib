defmodule ExBowers.FakeApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(
        scheme: :http,
        plug: ExBowers.FakeApp.Router,
        options: [port: 3080, protocol_options: [max_keepalive: 5_000_000]]
      )
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
