module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (Model, Msg(..))
import Dict

currentQuery : Model -> Html msg
currentQuery model =
    let
        query =
            toString model.location.query
    in
        span [ class "labelQuery" ]
             [ text query ]


dropdown : Html Msg
dropdown =
  ul [ class "dropdown-content", id "dropdown0" ]
    [ li []
          [ a [ href "#" ]
              [ text "Users" ]
          ]
    , li []
        [ a [ href "#" ]
            [ text "Settings" ]
        ]
    , li [ class "divider" ]
        []
    , li []
        [ a [ href "#" ]
            [ text "Login" ]
        ]
    ]


viewNavbar : Model -> Html Msg
viewNavbar model =
    div []
        [ div []
              [
                nav []
                [ div [ class "nav-wrapper" ]
                    [ a [ class "brand-logo", href "#!" ]
                        [ text "GrELMthinkDB" ]
                    , ul [ class "right hide-on-med-and-down" ]
                        [ li []
                            [ a [ href "#about"
                                , onClick (NavigateTo "about")
                                ]
                                [ text "Projects" ]
                            ]
                        , li []
                            [ a [ href "#"
                                , onClick (NavigateTo "")
                                ]
                                [ text "Links" ]
                            ]
                        , li []
                            [ a [ class "dropdown-button", attribute "data-activates" "dropdown0", href "#" ]
                                [ text "Admin"
                                , i [ class "material-icons right" ]
                                    [ text "arrow_drop_down" ]
                                ]
                            ]
                        ]
                    ]
                ]
            -- currentQuery model
             ]
        ]
