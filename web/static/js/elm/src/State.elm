module State exposing (..)

import Types exposing (Model, Msg(..))
import Item.State
import Item.Types
import GraphQL.GetLinks   as GetLinks   exposing (QueryLinksResult)
import GraphQL.CreateLink as CreateLink exposing (MutationResult)
import GraphQL.DeleteLink as DeleteLink exposing (DeleteLinkResult)
import Ports exposing (closeModal)
import Task
import Debug exposing (log)
import MyRouter exposing (..)
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Navigation


-- initialModel : Model
-- initialModel =
--     { items = []
--     , item = Item.State.initialModel
--     , searchStr = ""
--     , sortby = "title"
--     , sortdir = "asc"
--     }


toList queriedObject =
    queriedObject.store.linkConnection.edges

toMaybeNewItem queriedObject =
    queriedObject.createLink.linkEdge.node

toMaybeDelItem queriedObject =
    queriedObject.deleteLink.linkEdge.node

defaultItem item =
    Item.Types.Model
        (Maybe.withDefault "Missing id"        item.id)
        (Maybe.withDefault "Missing title"     item.title)
        (Maybe.withDefault "Missing url"       item.url)
        (Maybe.withDefault "Missing createdAt" item.createdAt)

edgeToItem edge =
    defaultItem edge.node


-- getQuery searchString sortString dirString =
--     GetLinks.queryLinks { queryParam = searchString, orderBy = sortString, orderDir = dirString}
--         |> Task.toMaybe
--         |> Task.perform (\_ -> NoOp) Get


-- postQuery item =
--     CreateLink.mutation { title = item.title, url = item.url }
--         |> Task.toMaybe
--         |> Task.perform (\_ -> NoOp) Add


-- delQuery str =
--     DeleteLink.deleteLink { id = str }
--         |> Task.toMaybe
--         |> Task.perform (\_ -> NoOp) Del


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =

  -- case (Debug.log "msg" msg) of
    case msg of
        NavigateTo path ->
            let
                command =
                    -- First generate the URL using your router config
                    -- Then generate a command using Navigation.modifyUrl
                    makeUrl routerConfig path
                        |> Navigation.modifyUrl
            in
                ( model, command )


        SetQuery query ->
            let
                command =
                    -- First modify the current stored location record (setting the query)
                    -- Then generate a URL using makeUrlFromLocation
                    -- Finally, create a command using Navigation.modifyUrl
                    model.location
                        |> setQuery query
                        |> makeUrlFromLocation routerConfig
                        |> Navigation.modifyUrl
            in
                ( model, command )


        NoOp ->
            ( model
            , Cmd.none
            )


        -- Get maybeQuery ->
        --     let
        --         newItems =
        --             case maybeQuery of
        --                 Just query ->
        --                     let
        --                         list =
        --                             toList query
        --                     in
        --                         List.map edgeToItem list

        --                 Nothing ->
        --                     []

        --         newModel =
        --             { model | items = newItems }
        --     in
        --         ( newModel
        --         , Cmd.none
        --         )


        -- Add maybeQuery ->
        --     let
        --         newModel =
        --           case maybeQuery of
        --               Just query ->
        --                   let
        --                       maybenewItem =
        --                           toMaybeNewItem query
        --                       newItem =
        --                           (defaultItem maybenewItem)
        --                   in
        --                       { model
        --                           | items = newItem :: model.items
        --                           -- , item = initialModel.item
        --                       }
        --               Nothing ->
        --                       model
        --     in
        --         ( newModel
        --         , closeModal ()
        --         )


        -- Del maybeQuery ->
        --     let newModel =
        --       case maybeQuery of
        --           Just query ->
        --                   let
        --                       maybedelItem = toMaybeDelItem query
        --                       delItem = (defaultItem maybedelItem)
        --                       id = delItem.id
        --                       -- logger = log "del id" id
        --                   in
        --                       { model | items = List.filter (\t -> t.id /= id) model.items }
        --           Nothing ->
        --                   model
        --     in
        --         ( newModel
        --         , Cmd.none
        --         )


        -- UpdateSearch str ->
        --     let
        --         newModel =
        --             { model | searchStr = str }
        --     in
        --         ( newModel
        --         , getQuery str model.sortby model.sortdir
        --         )


        -- TryAdd ->
        --     ( model
        --     , postQuery model.item
        --     )


        -- TryDel str ->
        --     ( model
        --     , delQuery str
        --     )


        -- UpdateTitle str ->
        --     let
        --         item =
        --             model.item

        --         updatedItem =
        --             { item | title = str }

        --         newModel =
        --             { model | item = updatedItem }

        --     in
        --         ( newModel
        --         , Cmd.none
        --         )


        -- UpdateUrl str ->
        --     let
        --         item =
        --             model.item

        --         updatedItem =
        --             { item | url = str }

        --         newModel =
        --             { model | item = updatedItem }
        --     in
        --         ( newModel
        --         , Cmd.none
        --         )


        -- Sortby sortby ->
        --     let
        --         newModel =
        --             { model | sortby = sortby }
        --     in
        --     ( newModel
        --     , getQuery model.searchStr sortby model.sortdir
        --     )

        -- Sortdir sortdir ->
        --     let
        --         newModel =
        --             { model | sortdir = sortdir }
        --     in
        --     ( newModel
        --     , getQuery model.searchStr model.sortby sortdir
        --     )

        -- SetItem item ->
        --     let
        --         newModel =
        --             { model | item = item }
        --     in
        --     ( newModel
        --     , Cmd.none
        --     )

        -- ClearItem ->
        --     let
        --         newModel =
        --             { model | item = Item.State.initialModel }
        --     in
        --     ( newModel
        --     , Cmd.none
        --     )
