defmodule ExBowers.ErrorView do
  import Plug.Conn
  
  def render(conn, :invalid_id) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, ~s({"error": "invalid id"}))
    |> halt()
  end  
end
