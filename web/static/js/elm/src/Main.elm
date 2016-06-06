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

-- init : String -> ( Model, Cmd Msg )
-- init sortString =
--     ( initialModel
--     , getQuery sortString initialModel.sortby initialModel.sortdir
--     )

init : ( Route, Hop.Types.Location ) -> ( Model, Cmd Msg )
init ( route, location ) =
    ( Model location route, Cmd.none )

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

-- main : Program Never
-- main =
--     Html.App.program
--         { init = init ""
--         , update = update
--         , subscriptions = subscriptions
--         , view = view
--         }
