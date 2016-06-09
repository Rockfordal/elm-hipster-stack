module Item.Views.AddModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (Msg(..))
import Item.Types exposing (..)

addItemModal : Model -> Html Msg
addItemModal item =
  div
      [ id "modal1"
      , class "modal modal-fixed-footer"
      ]
          [ Html.form []
          [ div [ class "modal-content" ]
              [ h5 []
                  [ text "New Link" ]
              , div [ class "input-field" ]
                  [ input
                      [ type' "text"
                      , id "newTitle"
                      -- , onInput UpdateTitle
                      , value item.title
                      , autofocus True
                      ]
                      []
                  , label [ for "newTitle" ]
                      [ text "Title" ]
                  ]
              , div [ class "input-field" ]
                  [ input
                      [ type' "text"
                      , id "newUrl"
                      -- , onInput UpdateUrl
                      , value item.url
                      ]
                      []
                  , label [ for "newUrl" ] [ text "Url" ]
                  ]
              ]
          , div [ class "modal-footer" ]
              [ button
                  [ class
                      ("waves-effect waves-green btn-flat green darken-3 "
                          ++ "white-text"
                      )
                  , type' "button"
                  -- , onClick (TryAdd)
                  ]
                  [ strong [] [ text "Add" ] ]
              , a
                  [ class
                      ("modal-action modal-close waves-effect waves-red "
                          ++ "btn-flat"
                      )
                  ]
                  [ text "Cancel" ]
              ]
          ]
      ]
