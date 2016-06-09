module Routes exposing (Sitemap(..), parsePath, navigateTo, toString)

import Navigation exposing (Location)
import Route exposing (..)


type Sitemap
    = HomeR ()
    | AboutR ()
    | NotFoundR


homeR =
    HomeR := static ""


aboutR =
    AboutR := static "about"


sitemap =
    router [ homeR, aboutR ]


match : String -> Sitemap
match =
    Route.match sitemap
        >> Maybe.withDefault NotFoundR


toString : Sitemap -> String
toString r =
    case r of
        HomeR () ->
            reverse homeR []

        AboutR () ->
            reverse aboutR []

        NotFoundR ->
            Debug.crash "cannot render NotFound"


parsePath : Location -> Sitemap
parsePath =
    .pathname >> match


navigateTo : Sitemap -> Cmd msg
navigateTo =
    toString >> Navigation.newUrl

