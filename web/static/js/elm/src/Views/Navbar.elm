module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (Msg(..))

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
                  [ li []
                      [ a [ href "#!" ]
                          [ text "Projects" ]
                      ]
                  , li []
                      [ a [ href "#!" ]
                          [ text "Links" ]
                      ]
                  , li []
                      [ a [ class "dropdown-button", attribute "data-activates" "dropdown1", href "#!" ]
                          [ text "Admin"
                          , i [ class "material-icons right" ]
                              [ text "arrow_drop_down" ]
                          ]
                      ]
                  ]
              ]
          ]
      ]
