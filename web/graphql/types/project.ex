defmodule App.Type.Project do
  alias GraphQL.Type.ObjectType
  @string %GraphQL.Type.String{}
  @type_string %{type: @string}

  def get do
    %ObjectType{
        name: "Project",
        fields: %{
          id: @type_string,
          name: @type_string,
          createdAt: %{
            type: @string,
            resolve: fn( obj, _args, _info) ->
              obj.timestamp
            end
          }
        }
      }
  end

end
