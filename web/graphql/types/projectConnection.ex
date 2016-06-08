defmodule App.Type.ProjectConnection do
  alias GraphQL.Type.List
  alias GraphQL.Relay.Connection

  def get do
    %{
      name: "Project",
      node_type: App.Type.Project.get,
      edge_fields: %{},
      connection_fields: %{},
      resolve_node: nil,
      resolve_cursor: nil
    } |> Connection.new
  end
end
