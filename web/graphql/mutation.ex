defmodule App.Mutation do
  # require Logger
  import List , only: [first: 1]
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.NonNull
  alias GraphQL.Type.String
  alias GraphQL.Type.NonNull
  alias GraphQL.Relay.Mutation
  alias RethinkDB.Query
  @store App.Utils.store


  def tree do
    %ObjectType{
      name: "Mutation",
      fields: %{
        createLink: Mutation.new(%{
          name: "CreateLink",
          input_fields: %{
            title: %{type: %NonNull{ofType: %String{}}},
            url: %{type: %NonNull{ofType: %String{}}}
          },
          output_fields: %{
            linkEdge: %{
              type: App.Type.LinkConnection.get[:edge_type],
              resolve: fn (obj, _args, _info) ->
                %{node: App.Query.Link.get_from_id(first(obj[:generated_keys])),
                  cursor: first(obj[:generated_keys])
                }
              end
            },
            store: %{
              type: App.Type.Store.get,
              resolve: fn (obj, _args, _info) ->
                @store
              end
            }
          },
          mutate_and_get_payload: fn(input, _info) ->
            Query.table("links")
              |> Query.insert(
                %{title: input[:title],
                  url: input[:url],
                  timestamp: TimeHelper.currentTime
                })
              |> DB.run
              |> DB.handle_graphql_resp
          end
        })
      } # fields
    } # mutation
  end
end
