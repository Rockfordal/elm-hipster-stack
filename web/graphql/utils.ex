defmodule App.Utils do
  alias GraphQL.Relay.Node

  @store %{ id: 1}


  def store do
    @store
  end

  def store_field do
    %{
      type: App.Type.Store.get,
      resolve: fn (doc, _args, _) ->
        store
      end
    }
  end

  def node_interface do Node.define_interface(fn(obj) ->
    IO.puts "node_interface"
    IO.inspect obj
    case obj do
      @store ->
          App.Type.Store.get
      _ ->
          %{}
      end
    end)
  end

  def node_field do
    Node.define_field(node_interface, fn (_item, args, _ctx) ->
      [type, id] = Node.from_global_id(args[:id])
      case type do
        "Store" ->
          @store
        _ ->
          %{}
      end
    end)
  end

end
