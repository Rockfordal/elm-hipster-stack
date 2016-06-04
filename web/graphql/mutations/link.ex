defmodule App.Mutations.Link do
  import List , only: [first: 1]
  alias GraphQL.Type.NonNull
  alias GraphQL.Type.String
  alias GraphQL.Type.NonNull
  alias GraphQL.Relay.Mutation
  alias RethinkDB.Query
  @notnullstring %{type: %NonNull{ofType: %String{}}}
  # require Logger


  def create do
    Mutation.new(%{
      name: "CreateLink",
      input_fields: %{
        title: @notnullstring,
        url:   @notnullstring
      },
      output_fields: %{
        linkEdge: %{
          type: App.Type.LinkConnection.get[:edge_type],
          resolve: fn (obj, _args, _info) ->
            %{
              node: App.Query.Link.get_from_id(first(obj[:generated_keys])),
              cursor: first(obj[:generated_keys])
            }
          end
        },
        store: App.Utils.getstore
      },
      mutate_and_get_payload: fn(input, _info) ->
        Query.table("links")
          |> Query.insert(
            %{
              title: input[:title],
              url: input[:url],
              timestamp: TimeHelper.currentTime
            })
          |> DB.run
          |> DB.handle_graphql_resp
      end
    })
  end

end
