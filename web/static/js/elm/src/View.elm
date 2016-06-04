module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (Model, Msg(..))
import Item.View exposing (viewItems)
import Json.Decode
import Debug exposing (log)


view : Model -> Html Msg
view model =
    let
        searchField =
            div [ class "input-field" ]
                [ input
                    [ type' "text"
                    , id "search"
                    , onInput UpdateSearch
                    ]
                    []
                , label [ for "search" ]
                    [ text "Search All Resources" ]
                ]

        orderBox =
            div []
                [ a [ class "dropdown-button btn", attribute "data-activates" "dropdown1", href "#" ]
                    [ text "Sortering" ]
                , ul [ class "dropdown-content", id "dropdown1" ]
                    [ li []
                        [ a [ href "#!"]
                            [ text "Titel" ]
                        ]
                    , li []
                        [ a [ href "#!" ]
                            [ text "Url" ]
                        ]
                    , li [ class "divider" ]
                        []
                    , li []
                        [ a [ href "#!" ]
                            [ text "Datum" ]
                        ]
                    ]
                ]

        addButton =
            a
                [ href "#modal1"
                , class
                    ("waves-effect waves-light btn modal-trigger right light-blue"
                        ++ " white-text"
                    )
                ]
                [ text "Add new resource" ]

        modal =
            div
                [ id "modal1"
                , class "modal modal-fixed-footer"
                ]
                   [ Html.form []
                    [ div [ class "modal-content" ]
                        [ h5 []
                            [ text "Add New Resource" ]
                        , div [ class "input-field" ]
                            [ input
                                [ type' "text"
                                , id "newTitle"
                                , onInput UpdateTitle
                                , value model.item.title
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
                                , value model.item.url
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
                            , onClick (TryAdd)
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
    in
        div []
            [ searchField
            , div [ class "row" ]
                [ addButton
                , orderBox
                ]
            , viewItems model.items
            , modal
            ]
