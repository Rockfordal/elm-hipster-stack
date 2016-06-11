module Item.Views.EditModal exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (Msg(..))
import Item.Types exposing (..)

editItemModal : Model -> Html Msg
editItemModal item =
  div
      [ id "modal2"
      , class "modal modal-fixed-footer"
      ]
          [ Html.form []
          [ div [ class "modal-content" ]
              [ h5 []
                  [ text "Edit Link" ]
              , div [ class "input-field" ]
                  [ input
                      [ type' "text"
                      , id "newTitle"
                      , onInput UpdateTitle
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
                      , onInput UpdateUrl
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
                  , onClick (TryUpdate)
                  ]
                  [ strong [] [ text "Update" ] ]
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
