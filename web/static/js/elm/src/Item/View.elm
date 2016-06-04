module Item.View exposing (viewItems)

import Html exposing (..)
import Html.Attributes exposing (class, style, href, target)
import Html.Events exposing (onClick)
import Item.Types exposing (Model)
import Types exposing (Msg(..))
import Regex


viewItem : Model -> Html Msg
viewItem item =
    li
        -- Should not need this. It is defined in Materialize CSS
        [ style [ ( "list-style-type", "none" ) ] ]
        [ div
            [ class "card-panel"
            , style [ ( "padding", "1em" ) ]
            ]
            [ a [ href item.url, target "_blank" ]
                [ text item.title ]
            , div [ class "truncate" ]
                [ span [ dateStyle ]
                    [ text item.createdAt ]
                , a
                    [ href item.url
                    , urlStyle
                    ]
                    [ text (urlPrettify item.url) ]
                , a
                    [ href "#"
                    , onClick (TryDel item.id)
                    , deleteStyle ]
                    [ i [ class "tiny material-icons"]
                        [ text "delete"]
                    ]
                ]
            ]
        ]


regex : String -> String
regex =
    Regex.replace Regex.All (Regex.regex "^https?://|/$") (\_ -> " ")


urlPrettify : String -> String
urlPrettify url =
    url
        |> regex


urlStyle : Attribute Msg
urlStyle =
    style
        [ ( "color", "#062" )
        , ( "fontSize", "0.85" )
        ]


dateStyle : Attribute Msg
dateStyle =
    style
        [ ( "color", "#888" )
        , ( "fontSize", "0.7em" )
        , ( "marginRight", "0.5em" )
        ]


deleteStyle : Attribute Msg
deleteStyle =
    style
        [ ( "color", "#e00" )
        , ( "fontSize", "0.8em" )
        , ( "marginLeft", "0.8em" )
        ]


viewItemList : List Model -> Html Msg
viewItemList itemList =
    itemList
        |> List.map viewItem
        |> div []


viewItems : List Model -> Html Msg
viewItems itemList =
    let
        itemsHtml =
            viewItemList itemList
    in
        div []
            [ itemsHtml ]
