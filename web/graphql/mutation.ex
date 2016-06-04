defmodule App.Mutation do
  alias GraphQL.Type.ObjectType


  def tree do
    %ObjectType{
      name: "Mutation",
      fields: %{
        createLink: App.Mutations.Link.create
      }
    }
  end
end
