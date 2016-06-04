defmodule App.Mutation do
  alias GraphQL.Type.ObjectType


  def tree do
    %ObjectType{
      name: "Mutation",
      fields: %{
        createLink: App.Mutations.Link.create,
        deleteLink: App.Mutations.Link.delete
      }
    }
  end
end
