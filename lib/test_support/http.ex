defmodule BowersLib.TestSupport.HTTP do
  def http_helper(router_module) do
    quote do
      use ExUnit.Case
      use Plug.Test

      import BowersLib.TestSupport.HTTP

      @opts unquote(router_module).init([])

      def post(endpoint, body \\ %{}) do
        conn = conn(:post, endpoint, body)
        conn = unquote(router_module).call(conn, @opts)

        format_helper_response(conn)
      end

      def get(endpoint) do
        conn = conn(:get, endpoint)
        conn = unquote(router_module).call(conn, @opts)

        format_helper_response(conn)
      end

      def format_helper_response(conn) do
        {
          status,
          headers,
          body
        } = sent_resp(conn)

        {status, Poison.decode!(body), headers}
      end
    end
  end

  defmacro __using__(router_module) do
    http_helper(router_module)
  end
end
