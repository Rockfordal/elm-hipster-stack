module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (Msg(..))
import Routes exposing (Sitemap(..))
import Json.Decode as Json


link : Sitemap -> String -> Html Msg
link route label =
    let
        opts =
            { preventDefault = True
            , stopPropagation = False
            }
    in
        a
            [ href (Routes.toString route)
            , onWithOptions "click" opts (Json.succeed <| RouteTo route)
            ]
            [ text label ]


viewNavbar : Html Msg
viewNavbar =
  div []
      [ ul [ class "dropdown-content", id "dropdown0" ]

          [ li []
              [ a [ href "#!" ]
                  [ text "Users" ]
              ]
          , li []
              [ a [ href "#!" ]
                  [ text "Settings" ]
              ]
          , li [ class "divider" ]
              []
          , li []
              [ a [ href "#!" ]
                  [ text "Login" ]
              ]
          ]
      , nav []
          [ div [ class "nav-wrapper" ]
              [ a [ class "brand-logo", href "#!" ]
                  [ text "GrELMthinkDB" ]
              , ul [ class "right hide-on-med-and-down" ]

                  [ li [] [ link (HomeR ()) "Home" ]
                  , li [] [ link (AboutR ()) "About" ]
                 , li []
                      [ a [ class "dropdown-button", attribute "data-activates" "dropdown0", href "#!" ]
                          [ text "Admin"
                          , i [ class "material-icons right" ]
                              [ text "arrow_drop_down" ]
                          ]
                      ]
                  ]
              ]
          ]
      ]
