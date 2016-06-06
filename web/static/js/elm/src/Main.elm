module Main exposing (..)

import Html.App
import State exposing (..) -- (initialModel, update, getQuery, routerConfig)
import Types exposing (..) -- (Model, Msg)
import View exposing (view)
import Navigation
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Hop.Matchers exposing (..)
import MyRouter exposing (matchers, routerConfig)
import Item.State

-- init : String -> ( Model, Cmd Msg )
-- init sortString =
--     ( initialModel
--     , getQuery sortString initialModel.sortby initialModel.sortdir
--     )

emptyItem = Item.State.initialModel

init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init ( route, location ) =
    ( Model location route [] emptyItem "" "" ""
    , getQuery "" "title" "asc"
    -- , getQuery sortString initialModel.sortby initialModel.sortdir
    )

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []


urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl routerConfig)


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate ( route, location ) model =
    ( { model | route = route, location = location }, Cmd.none )


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = (always Sub.none)
        , view = view
        }

--     Html.App.program
--         { init = init ""
--         , subscriptions = subscriptions
