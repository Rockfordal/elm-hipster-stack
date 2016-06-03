defmodule App.Type.Link do
  alias GraphQL.Type.ObjectType
  @string %GraphQL.Type.String{}
  @type_string %{type: @string}

  def get do
    %ObjectType{
        name: "Link",
        fields: %{
          id: @type_string,
          title: @type_string,
          url: @type_string,
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
