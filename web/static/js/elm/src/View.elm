module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue, onClick, onInput, onSubmit, onWithOptions)
import Types exposing (..) -- exposing (Model, Msg(..))
import Item.View exposing (viewItems)
import Json.Decode
import Debug exposing (log)
import Views.Navbar exposing (viewNavbar)
import Item.Views.AddModal exposing (addItemModal)
-- import Item.Views.EditModal exposing (editItemModal)


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


linksView : Model -> Html Msg
linksView model =
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
                        [ a [ href "#"
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
                      -- , onClick (Sortdir (invertdir dir))
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
                -- , onClick (ClearItem)
                ]
                [ i [ class "material-icons" ]
                    [ text "add" ]
                ]

    in
        div []
            [ div
                [ class "container"]
                [
                 searchField
                , div [ class "row" ]
                    [ addButton
                    , orderBox
                    , button [ onClick (Sortdir (invertdir model.sortdir))]
                             [ text "klicka" ]
                    , dirBox model.sortdir
                    ]
                , viewItems model.items
                , addItemModal model.item
--                 , editItemModal model.item
                ]
            ]


pageView : Model -> Html Msg
pageView model =
    case model.route of
        MainRoute ->
            linksView model

        ProjectsRoute ->
            div []
                [ h2
                   [ class "title" ]
                   [ text "Projects" ]
                ]

        NotFoundRoute ->
            div []
                [ h2 [ class "title" ] [ text "Not found" ] ]


view : Model -> Html Msg
view model =
    div []
        [ viewNavbar model
        , pageView model
        ]
