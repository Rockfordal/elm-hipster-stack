defmodule App.Mutations.Link do
  import List , only: [first: 1]
  alias GraphQL.Type.NonNull
  alias GraphQL.Type.String
  alias GraphQL.Type.NonNull
  alias GraphQL.Relay.Mutation
  alias RethinkDB.Query
  @notnullstring %{type: %NonNull{ofType: %String{}}}
  require Logger

  def logga msg do
    msg
    |> inspect
    |> Logger.debug
  end

  def create do
    Mutation.new(%{
          name: "CreateLink",
          input_fields: App.Type.Link.get.fields,
          # input_fields: %{
          #   title: @notnullstring,
          #   url:   @notnullstring
          # },
          output_fields: %{
            linkEdge: %{
              type: App.Type.LinkConnection.get[:edge_type],
              resolve: fn (obj, _args, _info) ->
                obj |> logga
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
                url:   input[:url],
                timestamp: TimeHelper.currentTime
              })
            |> DB.run
            |> DB.handle_graphql_resp
          end
      })
  end

  def update do
    Mutation.new(%{
      name: "UpdateLink",
      # input_fields: App.Type.Link.get.fields,
      input_fields: %{
          id:    @notnullstring,
          title: @notnullstring,
          url:   @notnullstring
        },
      output_fields: %{
        linkEdge: %{
          type: App.Type.LinkConnection.get[:edge_type],
          resolve: fn (obj, _args, _info) ->
            # obj |> logga
            %{
              node:
              %{
                id: obj[:id],
                title: obj[:title],
                url: obj[:url],
                timestamp: TimeHelper.currentTime
              },
              cursor: %{}
              # node: App.Query.Link.get_from_id(first(obj[:generated_keys])),
              # cursor: first(obj[:generated_keys])
            }
          end
        },
        store: App.Utils.getstore
      },
      mutate_and_get_payload: fn(input, _info) ->
          replaced = Query.table("links")
          |> Query.get(input[:id])
          |> Query.update(
            %{
              title: input[:title],
              url:   input[:url],
              timestamp: TimeHelper.currentTime
            })
          |> DB.run
          |> Map.fetch(:data)
          |> Tuple.to_list
          |> List.last
          |> Map.fetch("replaced")
          |> Tuple.to_list
          |> List.last
          # |> logga
          if replaced == 1 do
            input
          else
            %{}
          end
          # |> DB.handle_graphql_resp
      end
    })
  end

  def delete do
    Mutation.new(%{
          name: "DeleteLink",
          input_fields: %{
            id: @notnullstring,
          },
          output_fields: %{
            linkEdge: %{
              type: App.Type.LinkConnection.get[:edge_type],
              resolve: fn (obj, args, _info) ->
                # obj |> inspect |> Logger.debug
                %{
                  node: %{
                    timestamp: "2016-01-02",
                    id: obj[:id]
                  },
                  cursor: %{}
                  # node: App.Query.Link.get_from_id(first(obj[:generated_keys])),
                  # cursor: first(obj[:generated_keys])
                }
              end
            },
            store: App.Utils.getstore
          },
          mutate_and_get_payload: fn(input, _info) ->
            id = input[:id]
            deleted = Query.table("links")
            |> Query.get(id)
            |> Query.delete()
            |> DB.run
            |> Map.fetch(:data)
            |> Tuple.to_list
            |> List.last
            |> Map.fetch("deleted")
            |> Tuple.to_list
            |> List.last
            # |> DB.handle_graphql_resp
            if deleted == 1 do
              %{id: id}
            else
              %{}
            end
          end
      })
  end

end
