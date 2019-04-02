defmodule ExBowers.FakeApp.Router do
  use Plug.Router
  use Plug.Debugger
  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, ~s({"get_status": "ok"}))
  end

  post "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, ~s({"post_status": "ok"}))
  end
end
