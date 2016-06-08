defmodule App.Type.Store do
  alias GraphQL.Type.ObjectType
  alias GraphQL.Relay.Node
  alias App.Utils


  def get do
    %ObjectType{
      name: "Store",
      fields: %{
        id: Node.global_id_field("Store"),
        linkConnection: App.Query.Link.get,
        projectConnection: App.Query.Project.get
      },
      interfaces: [Utils.node_interface]
    }
  end
end
