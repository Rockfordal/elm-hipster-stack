defmodule App.PublicSchema do
  alias GraphQL.Schema
  alias GraphQL.Type.ObjectType
  alias App.Utils


  def schema do
    %Schema{
      query: %ObjectType{
        name: "Query",
        fields: %{
          node:  Utils.node_field,
          store: Utils.store_field
        }
      },
      mutation: App.Mutation.tree
    }
  end
end
