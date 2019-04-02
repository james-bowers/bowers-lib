defmodule ExBowers.Plug.ValidatePathIds do
  alias ExBowers.ErrorView

  def init(opts), do: opts

  def call(conn, path_ids) do
    case has_valid_ids?(conn, path_ids) do
      true ->
        conn

      false ->
        ErrorView.render(conn, :invalid_id)
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
