defmodule App.Type.Store do
  alias GraphQL.Schema
  alias GraphQL.Type.ObjectType
  alias GraphQL.Relay.Node
  alias GraphQL.Relay.Mutation

  def get do
    %ObjectType{
      name: "Store",
      fields: %{
        id: Node.global_id_field("Store"),
        linkConnection: App.Query.Link.get
      },
      interfaces: [App.Utils.node_interface]
    }
  end
end
