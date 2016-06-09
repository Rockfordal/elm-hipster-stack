module Main exposing (..)

-- import Html.App
import Navigation
import Routes
-- import State exposing (initialModel, update, urlUpdate, getQuery, init)
import State exposing (update, urlUpdate, init)
import Types exposing (Model, Msg)
import View exposing (view)


-- init : String -> ( Model, Cmd Msg )
-- init sortString =
--     ( initialModel
--     , getQuery sortString initialModel.sortby initialModel.sortdir
--     )


-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     Sub.batch []


main : Program Never
main =
    Navigation.program (Navigation.makeParser Routes.parsePath)
        -- { init = Update.init
        { init = init
        , update = update
        , urlUpdate = urlUpdate
        , view = view
        , subscriptions = \_ -> Sub.batch []
        -- , subscriptions = subscriptions
        }

    -- Html.App.program
    --     { init = init ""
    --     , update = update
    --     , subscriptions = subscriptions
    --     , view = view
    --     }
