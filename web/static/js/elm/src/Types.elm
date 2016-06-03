module Types exposing (..)

import Item.Types
import GraphQL.Ahead as Ahead exposing (QueryLinksResult)
import GraphQL.Hoho as Hoho exposing (MutationResult)

type alias Model =
    { items : List Item.Types.Model
    , item : Item.Types.Model
    , searchStr : String
    }


type Msg
    = NoOp
    | NewQuery (Maybe QueryLinksResult)
    | Add (Maybe MutationResult)
    | TryAdd
    | UpdateSearch String
    | UpdateTitle String
    | UpdateUrl String


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
