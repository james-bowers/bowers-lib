defmodule ExBowers.FakeApp.Router do
  use Plug.Router
  use Plug.Debugger

  plug(:match)
  plug(ExBowers.Plug.ValidatePathIds, ["an_ecto_id"])
  plug(:dispatch)

  get "/resource/:an_ecto_id" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, ~s({"get_resource": "ok"}))
  end

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
