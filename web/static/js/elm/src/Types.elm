module Types exposing (..)

import Item.Types
import GraphQL.GetLinks   as GetLinks   exposing (QueryLinksResult)
import GraphQL.CreateLink as CreateLink exposing (MutationResult)
import GraphQL.DeleteLink as DeleteLink exposing (DeleteLinkResult)
import GraphQL.UpdateLink as UpdateLink exposing (UpdateLinkResult)
import Routes exposing (Sitemap(..))


type alias Model =
    { route : Sitemap
    , ready : Bool
    , error : Maybe String
    , searchStr : String
    , sortby : String
    , sortdir : String
    , items : List Item.Types.Model
    , item : Item.Types.Model
    }


type Msg
    = NoOp
    | RouteTo Sitemap
    | UpdateSearch String
    | Sortby String
    | Sortdir String
    | ClearItem
    | UpdateTitle String
    | UpdateUrl String
    | Get (Maybe QueryLinksResult)
    | Add (Maybe MutationResult)
    | Del (Maybe DeleteLinkResult)
    | Update (Maybe UpdateLinkResult)
    | TryAdd
    | TryDel String
    | TryUpdate
    | SetItem Item.Types.Model


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
