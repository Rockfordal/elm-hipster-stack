module State exposing (..)

import Types exposing (Model, Msg(..))
import Item.State
import Item.Types
import GraphQL.Ahead as Ahead exposing (QueryLinksResult)
import GraphQL.Hoho as Hoho exposing (MutationResult)
import Ports exposing (closeModal)
import Task
import Debug exposing (log)


initialModel : Model
initialModel =
    { items = []
    , item = Item.State.initialModel
    , searchStr = ""
    }


toList queriedObject =
    queriedObject.store.linkConnection.edges

toMaybeNewItem queriedObject =
    queriedObject.createLink.linkEdge.node

edgeToItem edge =
    Item.Types.Model
        (Maybe.withDefault "Missing id"        edge.node.id)
        (Maybe.withDefault "Missing title"     edge.node.title)
        (Maybe.withDefault "Missing url"       edge.node.url)
        (Maybe.withDefault "Missing createdAt" edge.node.createdAt)

defaultNewItem item =
    Item.Types.Model
        (Maybe.withDefault "Missing id"        item.id)
        (Maybe.withDefault "Missing title"     item.title)
        (Maybe.withDefault "Missing url"       item.url)
        (Maybe.withDefault "Missing createdAt" item.createdAt)


getQuery sortString =
    Ahead.queryLinks { queryParam = sortString }
        |> Task.toMaybe
        |> Task.perform (\_ -> NoOp) NewQuery


putQuery item =
    Hoho.mutation { title = item.title, url = item.url }
        |> Task.toMaybe
        |> Task.perform (\_ -> NoOp) Add


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model
            , Cmd.none
            )


        NewQuery maybeQuery ->
            let
                newItems =
                    case maybeQuery of
                        Just query ->
                            let
                                list =
                                    toList query
                            in
                                List.map edgeToItem list

                        Nothing ->
                            []

                newModel =
                    { model | items = newItems }
            in
                ( newModel
                , Cmd.none
                )


        Add maybeQuery ->
            let
                newModel =
                  case maybeQuery of
                      Just query ->
                          let
                              maybenewItem =
                                  toMaybeNewItem query
                              newItem =
                                  (defaultNewItem maybenewItem)
                          in
                              { model
                                  | items = newItem :: model.items
                              , item = initialModel.item
                              }
                      Nothing ->
                              model
            in
                ( newModel
                , closeModal ()
                )


        UpdateSearch str ->
            let
                newModel =
                    { model | searchStr = str }
            in
                ( newModel
                , getQuery str
                )


        TryAdd ->
            ( model
            , putQuery model.item
            )


        UpdateTitle str ->
            let
                item =
                    model.item

                updatedItem =
                    { item | title = str }

                newModel =
                    { model | item = updatedItem }

            in
                ( newModel
                , Cmd.none
                )


        UpdateUrl str ->
            let
                item =
                    model.item

                updatedItem =
                    { item | url = str }

                newModel =
                    { model | item = updatedItem }
            in
                ( newModel
                , Cmd.none
                )
