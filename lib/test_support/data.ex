defmodule ExBowers.TestSupport.Data do
  def data_helper(repo_module) do
    quote do
      use ExUnit.CaseTemplate
      use ExUnit.Case

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import ExBowers.TestSupport.Data
      alias unquote(repo_module)

      setup tags do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(unquote(repo_module))

        unless tags[:async] do
          Ecto.Adapters.SQL.Sandbox.mode(unquote(repo_module), {:shared, self()})
        end

        :ok
      end

      def errors_on(changeset) do
        Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
          Enum.reduce(opts, message, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
      end
    end
  end

  defmacro __using__(repo_module) do
    data_helper(repo_module)
  end
end
