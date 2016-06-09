module Main exposing (..)

import Navigation
import Routes
import State exposing (update, urlUpdate, init)
import Types exposing (Model, Msg)
import View exposing (view)


main : Program Never
main =
    Navigation.program (Navigation.makeParser Routes.parsePath)
        { init = init
        , update = update
        , urlUpdate = urlUpdate
        , view = view
        , subscriptions = \_ -> Sub.batch []
        }
