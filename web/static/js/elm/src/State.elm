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
import Navigation exposing (Location)
import Routes exposing (Sitemap(..))


-- initialModel : Model
-- initialModel =
--     , item = Item.State.initialModel
--     , searchStr = ""
--     , sortby = "title"
--     , sortdir = "asc"
--     }


init : Sitemap -> ( Model, Cmd Msg )
init route =
    urlUpdate route
        { route = route
        , ready = False
        -- , posts = []
        -- , post = Nothing
        , error = Nothing
        }

-- toList queriedObject =
--     queriedObject.store.linkConnection.edges

-- toMaybeNewItem queriedObject =
--     queriedObject.createLink.linkEdge.node

-- toMaybeDelItem queriedObject =
--     queriedObject.deleteLink.linkEdge.node

-- defaultItem item =
--     Item.Types.Model
--         (Maybe.withDefault "Missing id"        item.id)
--         (Maybe.withDefault "Missing title"     item.title)
--         (Maybe.withDefault "Missing url"       item.url)
--         (Maybe.withDefault "Missing createdAt" item.createdAt)

-- edgeToItem edge =
--     defaultItem edge.node


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
update msg ({ route } as model) =
    case msg of
        RouteTo route ->
            model ! [ Routes.navigateTo route ]

        -- FetchError error ->
        --     { model | error = Just (toString error) } ! []

        -- FetchSuccess posts ->
        --     urlUpdate route { model | ready = True, error = Nothing, posts = posts }


-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         NoOp ->
--             ( model
--             , Cmd.none
--             )


--         Get maybeQuery ->
--             let
--                 newItems =
--                     case maybeQuery of
--                         Just query ->
--                             let
--                                 list =
--                                     toList query
--                             in
--                                 List.map edgeToItem list

--                         Nothing ->
--                             []

--                 newModel =
--                     { model | items = newItems }
--             in
--                 ( newModel
--                 , Cmd.none
--                 )


--         Add maybeQuery ->
--             let
--                 newModel =
--                   case maybeQuery of
--                       Just query ->
--                           let
--                               maybenewItem =
--                                   toMaybeNewItem query
--                               newItem =
--                                   (defaultItem maybenewItem)
--                           in
--                               { model
--                                   | items = newItem :: model.items
--                                   , item = initialModel.item
--                               }
--                       Nothing ->
--                               model
--             in
--                 ( newModel
--                 , closeModal ()
--                 )


--         Del maybeQuery ->
--             let newModel =
--               case maybeQuery of
--                   Just query ->
--                           let
--                               maybedelItem = toMaybeDelItem query
--                               delItem = (defaultItem maybedelItem)
--                               id = delItem.id
--                               -- logger = log "del id" id
--                           in
--                               { model | items = List.filter (\t -> t.id /= id) model.items }
--                   Nothing ->
--                           model
--             in
--                 ( newModel
--                 , Cmd.none
--                 )


--         UpdateSearch str ->
--             let
--                 newModel =
--                     { model | searchStr = str }
--             in
--                 ( newModel
--                 , getQuery str model.sortby model.sortdir
--                 )


--         TryAdd ->
--             ( model
--             , postQuery model.item
--             )


--         TryDel str ->
--             ( model
--             , delQuery str
--             )


--         UpdateTitle str ->
--             let
--                 item =
--                     model.item

--                 updatedItem =
--                     { item | title = str }

--                 newModel =
--                     { model | item = updatedItem }

--             in
--                 ( newModel
--                 , Cmd.none
--                 )


--         UpdateUrl str ->
--             let
--                 item =
--                     model.item

--                 updatedItem =
--                     { item | url = str }

--                 newModel =
--                     { model | item = updatedItem }
--             in
--                 ( newModel
--                 , Cmd.none
--                 )


--         Sortby sortby ->
--             let
--                 newModel =
--                     { model | sortby = sortby }
--             in
--             ( newModel
--             , getQuery model.searchStr sortby model.sortdir
--             )

--         Sortdir sortdir ->
--             let
--                 newModel =
--                     { model | sortdir = sortdir }
--             in
--             ( newModel
--             , getQuery model.searchStr model.sortby sortdir
--             )

--         SetItem item ->
--             let
--                 newModel =
--                     { model | item = item }
--             in
--             ( newModel
--             , Cmd.none
--             )

--         ClearItem ->
--             let
--                 newModel =
--                     { model | item = Item.State.initialModel }
--             in
--             ( newModel
--             , Cmd.none
--             )


urlUpdate : Sitemap -> Model -> ( Model, Cmd Msg )
urlUpdate route ({ ready } as m) =
    let
        model =
            { m | route = route }
    in
        case route of
            -- PostsR () ->
            --     if ready then
            --         model ! []
            --     else
            --         model ! [ fetchPosts ]

            -- PostR id ->
            --     if ready then
            --         { model | post = Data.lookupPost id model.posts } ! []
            --     else
            --         model ! [ fetchPosts ]

            _ ->
                model ! []
