defmodule App.Query.Link do
  alias GraphQL.Type.List
  alias GraphQL.Type.ID
  alias GraphQL.Type.NonNull
  alias GraphQL.Relay.Connection
  import RethinkDB.Lambda, only: [lambda: 1]
  import RethinkDB.Query,  only: [table: 1, order_by: 2, asc: 1, desc: 1, filter: 2, match: 2, get: 2]
  @type_string %{type: %GraphQL.Type.String{}}
  require Logger

  def get_from_id(id) do
    table("links")
    |> get(id)
    |> DB.run
    |> DB.handle_graphql_resp
  end

  def get_fields do
    %{
      query: @type_string,
      order_by: @type_string,
      order_dir: @type_string
    }
  end

  def get_order args do
    odir = args[:order_dir]
    ofield = args[:order_by]
    order =
      case odir do
        "asc" -> asc(ofield)
        _     -> desc(ofield)
      end
  end

  def get do
    %{
      type: App.Type.LinkConnection.get[:connection_type],
      args: Map.merge(Connection.args, get_fields),
      resolve: fn ( _, args , _ctx) ->
        table("links")
        |> filter(lambda fn(link) ->
          match(
            link[:title],
            args[:query])
          end)
        |> order_by(get_order args)
        |> DB.run
        |> DB.handle_graphql_resp
        |> Connection.List.resolve(args)
      end
    }
  end

end
