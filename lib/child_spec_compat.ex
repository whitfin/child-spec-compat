defmodule ChildSpecCompat do
  @moduledoc """
  Provides Elixir compatibility for versions prior to v1.5.

  The new `Supervisor.child_spec/2` functions are recommended but only
  exist after Elixir v1.5. This is not easy to migrate to inside library
  modules which support multiple Elixir versions, and so this module
  aims to make this transition easier. This works by transforming the
  new form back to the old style to allow migration to the new patterns.
  """

  @doc """
  Builds and overrides a child specification.

  This will pass straight through to the `Supervisor` child specification
  functions on Elixir v1.5, and wrap into an older record format on older
  versions.

  You can use this when your code targets Elixir runtimes both prior to
  and after Elixir v1.5 (e.g. libraries and common modules).
  """
  defmacro child_spec(module_or_map, overrides \\ []) do
    has_child_spec =
      :functions
      |> Supervisor.__info__()
      |> Keyword.keys()
      |> Enum.member?(:child_spec)

    case has_child_spec do
      true ->
        quote bind_quoted: binding() do
          Supervisor.child_spec(module_or_map, overrides)
        end

      false ->
        quote bind_quoted: binding() do
          # specification shimming
          modified_spec =
            Enum.reduce(
              # iteratee
              overrides,

              # generate initial child specification
              case module_or_map do
                # specification is provided
                map when is_map(map) ->
                  map

                # only module is provided
                mod when is_atom(mod) ->
                  mod.child_spec([])

                # module and arguments are provded
                {mod, args} when is_atom(mod) ->
                  mod.child_spec(args)
              end,

              # apply overrides to spec
              fn {field, value}, spec ->
                Map.put(spec, field, value)
              end
            )

          # :id and :start are required
          id = Map.fetch!(modified_spec, :id)
          start = Map.fetch!(modified_spec, :start)

          # :type and :restart allow default values
          type = Map.get(modified_spec, :type, :worker)
          restart = Map.get(modified_spec, :restart, :permanent)

          # the shutdown needs to know the child :type value
          shutdown = Map.get_lazy(modified_spec, :shutdown, fn ->
            case type do
              :supervisor -> :infinity
              :worker -> 5000
            end
          end)

          # restructure all into the old tuple format
          { id, start, restart, shutdown, type, [id] }
        end
    end
  end
end
