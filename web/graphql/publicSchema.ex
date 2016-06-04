defmodule App.PublicSchema do
  alias GraphQL.Schema
  alias GraphQL.Type.ObjectType

  def schema do
    %Schema{
      query: %ObjectType{
        name: "Query",
        fields: %{
          node: App.Utils.node_field,
          store: App.Utils.store_field
        }
      },
      mutation: App.Mutation.tree
    }
  end
end
