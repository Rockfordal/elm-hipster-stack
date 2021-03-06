module Types exposing (..)

import Item.Types
import GraphQL.GetLinks   as GetLinks exposing (QueryLinksResult)
import GraphQL.CreateLink as CreateLink exposing (MutationResult)
import GraphQL.DeleteLink as DeleteLink exposing (DeleteLinkResult)

type alias Model =
    { items : List Item.Types.Model
    , item : Item.Types.Model
    , searchStr : String
    , sortby : String
    , sortdir : String
    }


type Msg
    = NoOp
    | Get (Maybe QueryLinksResult)
    | Add (Maybe MutationResult)
    | Del (Maybe DeleteLinkResult)
    | TryAdd
    | TryDel String
    | UpdateSearch String
    | UpdateTitle String
    | UpdateUrl String
    | Sortby String
    | Sortdir String
    | SetItem Item.Types.Model
    | ClearItem


type alias Edge =
    { node :
        { id : Maybe String
        , title : Maybe String
        , url : Maybe String
        , createdAt : Maybe String
        }
    }


type alias QueryResult a b c d =
    { d
        | store :
            { c
                | linkConnection :
                    { b
                        | edges :
                            a
                    }
            }
    }
