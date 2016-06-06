module MyRouter exposing (..)
import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Hop.Matchers exposing (..)
import Types exposing (..) -- (Model, Msg)

matchers : List (PathMatcher Route)
matchers =
    [ match1 MainRoute ""
    , match1 ProjectsRoute "/about"
    ]

routerConfig : Config Route
routerConfig =
    { hash = True
    , basePath = ""
    , matchers = matchers
    , notFound = NotFoundRoute
    }
