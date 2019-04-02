defmodule ExBowers.Plug.ValidatePathIds do
  import Plug.Conn

  def temp_error_view(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, ~s({"error": "invalid id"}))
    |> halt()
  end

  def init(opts), do: opts

  def call(conn, path_ids) do
    case has_valid_ids?(conn, path_ids) do
      true ->
        conn

      false ->
        temp_error_view(conn)
    end
  end

  defp has_valid_ids?(conn, path_ids) do
    conn.path_params
    |> Map.take(path_ids)
    |> Enum.map(fn {_key, value} ->
      case Ecto.UUID.cast(value) do
        {:ok, _} -> true
        :error -> false
      end
    end)
    |> Enum.all?()
  end
end
