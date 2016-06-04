module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (Model, Msg(..))
import Item.View exposing (viewItems)
import Json.Decode
import Debug exposing (log)
import Views.Navbar exposing (viewNavbar)

diricon : String -> String
diricon dir =
    case dir of
        "asc" -> "trending_up"
        _     -> "trending_down"

invertdir : String -> String
invertdir dir =
    case dir of
        "asc" -> "desc"
        _     -> "asc"

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
                    [ text "Search" ]
                ]

        orderBox =
            div [class "col"]
                [ a [ class "dropdown-button btn-flat", attribute "data-activates" "dropdown1", href "#" ]
                    [ text "Sort by"
                    , i [ class "material-icons right" ]
                        [ text "arrow_drop_down" ]
                    ]
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

        dirBox dir =
            div [class "col"]
                [ a [ href "#!"]
                  [ i [ class "material-icons"
                      , onClick (Sortdir (invertdir dir))
                      ]
                      [ text (diricon dir)
                      ]
                  ]
                ]

        addButton =
            a
                [ href "#modal1"
                , class
                    ("btn-floating waves-effect waves-light modal-trigger grey right"
                    )
                ]
                -- [ text "New Link" ]
                [ i [ class "material-icons" ]
                    [ text "add" ]
                ]

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
                    , dirBox model.sortdir
                    ]
                , viewItems model.items
                , modal
                ]
            ]
