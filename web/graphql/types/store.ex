defmodule App.Type.Store do

  alias GraphQL.Schema
  alias GraphQL.Type.ObjectType
  alias GraphQL.Type.ID
  alias GraphQL.Type.NonNull
  alias GraphQL.Relay.Node
  alias GraphQL.Relay.Connection
  alias GraphQL.Relay.Mutation
  import RethinkDB.Lambda, only: [lambda: 1]
  import RethinkDB.Query, only: [table: 1, order_by: 2, desc: 1, filter: 2, match: 2]
  @type_string %{type: %GraphQL.Type.String{}}


  def get do
    %ObjectType{
      name: "Store",
      fields: %{
        id: Node.global_id_field("Store"),
        linkConnection: %{
          type: App.Type.LinkConnection.get[:connection_type],
          args: Map.merge(Connection.args, %{query: @type_string}),
          resolve: fn ( _, args , _ctx) ->
            query = table("links")
              |> filter(lambda fn(link) ->
                match(link[:title],
                args[:query]) end)
              |> order_by(desc("timestamp"))
              |> DB.run
              |> DB.handle_graphql_resp
          Connection.List.resolve(query, args)
          end
        }
      },
      interfaces: [App.Utils.node_interface]
    }
  end
end
