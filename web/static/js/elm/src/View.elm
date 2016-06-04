module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (Model, Msg(..))
import Item.View exposing (viewItems)
import Json.Decode
import Debug exposing (log)
import Views.Navbar exposing (viewNavbar)

view : Model -> Html Msg
view model =
    let
        navBar = viewNavbar
        searchField =
            div [ class "input-field" ]
                [ input
                    [ type' "text"
                    , id "search"
                    , onInput UpdateSearch
                    ]
                    []
                , label [ for "search" ]
                    [ text "Search Links" ]
                ]

        orderBox =
            div [class "col"]
                [ a [ class "dropdown-button btn", attribute "data-activates" "dropdown1", href "#" ]
                    [ text "Sortering" ]
                , ul [ class "dropdown-content", id "dropdown1" ]
                    [ li []
                        [ a [ href "#!"
                            , onClick (Sortby "title")
                            ]
                            [ text "Titel" ]
                        ]
                    , li []
                        [ a [ href "#!"
                            , onClick (Sortby "url")
                            ]
                            [ text "Url" ]
                        ]
                    , li [ class "divider" ]
                        []
                    , li []
                        [ a [ href "#!"
                            , onClick (Sortby "timestamp")
                            ]
                            [ text "Datum" ]
                        ]
                    ]
                ]

        dirBox =
            div [class "col"]
                [ a [ class "dropdown-button btn", attribute "data-activates" "dropdown2", href "#" ]
                    [ text "Riktning" ]
                , ul [ class "dropdown-content", id "dropdown2" ]
                    [ li []
                        [ a [ href "#!"
                            , onClick (Sortdir "asc")
                            ]
                            [ text "Asc" ]
                        ]
                    , li []
                        [ a [ href "#!"
                            , onClick (Sortdir "desc")
                            ]
                            [ text "Desc" ]
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
                [ text "New Link" ]

        modal =
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
            [ navBar
            , div
                [ class "container"]
                [ searchField
                , div [ class "row" ]
                    [ addButton
                    , orderBox
                    , dirBox
                    ]
                , viewItems model.items
                , modal
                ]
            ]
