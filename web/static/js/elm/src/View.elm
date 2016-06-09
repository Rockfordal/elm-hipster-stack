module View exposing (..) -- (view)

import Html exposing (..)
import Html.Attributes exposing (..) -- (href)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Json.Decode as Json
import Routes exposing (Sitemap(..))
import Types exposing (Model, Msg(..))
import Item.View exposing (viewItems)
import Debug exposing (log)
import Views.Navbar exposing (viewNavbar)
import Item.Views.AddModal exposing (addItemModal)
import Item.Views.EditModal exposing (editItemModal)


notFound : Html Msg
notFound =
    h1 [] [ text "Page not found" ]

about : Model -> Html Msg
about model =
    h1 [] [ text "About" ]


home : Model -> Html Msg
home model =
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
                    ("btn-floating waves-effect waves-light modal-trigger grey right")

                , onClick (ClearItem)
                ]
                [ i [ class "material-icons" ]
                    [ text "add" ]
                ]
    in
    div []
        [ searchField
        , div [ class "row" ]
            [ addButton
            , orderBox
            , dirBox model.sortdir
            ]
        , viewItems model.items
        , addItemModal model.item
        , editItemModal model.item
        ]
        -- , p [] [ link (PostR 123) "This post does not exist" ]


loading : Html Msg
loading =
    h1 [] [ text "Loading..." ]


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

    in
        div []
            [ navBar
            , div [ class "container"]
                  [
                    case model.route of
                      HomeR () ->
                          home model

                      AboutR () ->
                          about model

                      NotFoundR ->
                          notFound
                ]
            ]
