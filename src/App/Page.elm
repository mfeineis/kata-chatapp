module App.Page exposing (Intent(..), Model, view)

import App.Layout as Layout
import App.Stream as Stream exposing (Stream, Topic)
import Browser
import Html exposing (Html, button, div, input, li, ol, span, text)
import Html.Attributes as Attr exposing (class, disabled, placeholder)


type alias Model =
    { streams : List Stream
    }


type Intent
    = NoOp


view : Model -> Browser.Document Intent
view model =
    { title = "Chat"
    , body =
        [ Layout.layout []
            [ Layout.layoutContent []
                [ header model
                , Layout.mainContent [ Attr.attribute "role" "main" ]
                    [ toolPanel model
                    , toolPanelMenu model
                    , streamPanel model
                    , detailPanel model
                    , threadPanel model
                    ]
                ]
            ]
        ]
    }



-- HEADER


header _ =
    div [ class "panel-menu panel-menu--header" ]
        [ div [ class "panel-menu__title" ] [ text "Almanac" ]
        , div [ class "panel-menu__textfield" ]
            [ input [ placeholder "What are you looking for?" ] []
            ]
        , div [ class "panel-menu__menu" ]
            [ button [ class "btn btn--icon" ]
                [ text "🍔"
                , span [ class "pill pill--sup pill--primary" ] [ text "3" ]
                ]
            ]
        ]


toolPanel _ =
    div [ class "tool-panel" ]
        [ ol [ class "tool-panel__items" ]
            [ li [ class "tool-panel__item" ]
                [ button [ class "btn btn--icon" ]
                    [ text "\u{1F9EA}"
                    ]
                ]
            , li [ class "tool-panel__item" ]
                [ button [ class "btn btn--icon" ]
                    [ text "👔"
                    , span [ class "pill pill--sup" ] [ text "1" ]
                    ]
                ]
            , li [ class "tool-panel__item" ]
                [ button [ class "btn btn--icon" ]
                    [ text "👕"
                    ]
                ]
            , li [ class "tool-panel__item" ]
                [ button [ class "btn btn--icon" ]
                    [ text "👗"
                    ]
                ]
            ]
        , ol [ class "tool-panel__tools" ]
            [ li [ class "tool-panel__item" ]
                [ button [ class "btn btn--icon" ]
                    [ text "⚙️"
                    ]
                ]
            ]
        ]


toolPanelMenu _ =
    div [ class "tool-panel__menu x-tool-panel__menu--floating" ]
        [ ol [ class "tool-panel__items" ]
            [ li [ class "tool-panel__item" ]
                [ Layout.menuEntry []
                    [ Layout.menuEntryIcon [] [ text "\u{1F9F6}" ]
                    , Layout.menuEntryLabel [] [ text "Do Something" ]
                    ]
                ]
            , li [ class "tool-panel__item" ]
                [ Layout.menuEntry []
                    [ Layout.menuEntryIcon [] [ text "\u{1F9F8}" ]
                    , Layout.menuEntryLabel [] [ text "Do Another Thing" ]
                    ]
                ]
            ]
        , ol [ class "tool-panel__tools" ]
            [ li [ class "tool-panel__item" ]
                [ Layout.menuEntry []
                    [ Layout.menuEntryIcon [] [ text "\u{1F97C}" ]
                    , Layout.menuEntryLabel [] [ text "Experimental" ]
                    ]
                ]
            ]
        ]



-- STREAMS


streamPanel : { a | streams : List Stream } -> Html Intent
streamPanel { streams } =
    div [ class "tool-panel__menu" ]
        [ ol [ class "tool-panel__items" ]
            (List.map streamItem streams)
        ]


streamItem : Stream -> Html Intent
streamItem stream =
    li [ class "tool-panel__item" ]
        [ Layout.streamItem [ class "stream-item--highlighted" ]
            [ Layout.streamItemIcon [] [ text "💢" ]
            , Layout.streamItemLabel [] [ text (Stream.name stream) ]
            , span [ class "stream-item__adornment" ]
                [ span [ class "inline-pill pill--primary" ]
                    [ text "1" ]
                ]
            ]
        , ol [ class "tool-panel__items" ]
            (List.map topicItem (Stream.topics stream))
        ]


topicItem : Topic -> Html Intent
topicItem name =
    li [ class "tool-panel__item tool-panel__item" ]
        [ Layout.streamItem [ class "stream-item--sub" ]
            [ Layout.streamItemIcon [] [ text "📎" ]
            , Layout.streamItemLabel [] [ text (Stream.topicName name) ]
            ]
        ]



-- DETAILS


detailPanel : a -> Html Intent
detailPanel _ =
    div [ class "detail-panel" ]
        [ ol [ class "panel-menu" ]
            [ li [ class "panel-menu__spacer" ] []
            , li [ class "panel-menu__menu" ]
                [ button [ class "btn btn--icon" ]
                    [ text "🍔"
                    ]
                ]
            ]
        , div [ class "panel-content" ]
            [ text "Details..."
            , button
                [ disabled True
                , class "btn btn--primary"
                ]
                [ text "A disabled button" ]
            , text "Some more text and finally"
            , button
                [ class "btn btn--primary"
                ]
                [ text "An active button" ]
            , button
                [ class "btn btn--primary btn--sm"
                ]
                [ text "A small button" ]
            , button
                [ class "btn btn--primary btn--lg"
                ]
                [ text "A large button" ]
            ]
        ]



-- THREADS


threadPanel : a -> Html Intent
threadPanel _ =
    div [ class "thread-panel" ]
        [ ol [ class "panel-menu" ]
            [ li []
                [ button
                    [ class "btn btn--icon"
                    , disabled True
                    ]
                    [ text "🖌"
                    ]
                ]
            , li []
                [ button
                    [ class "btn btn--primary btn--icon"
                    ]
                    [ text "💡"
                    ]
                ]
            , li [ class "panel-menu__title" ]
                [ text "Conversation"
                ]
            , li [ class "panel-menu__spacer" ] []
            , li [ class "panel-menu__menu" ]
                [ button [ class "btn btn--icon" ]
                    [ text "🐣"
                    ]
                ]
            ]
        , div [ class "panel-content" ]
            [ text "Content"
            ]
        , div [ class "panel-menu panel-menu--footer" ]
            [ div [ class "panel-menu__textfield" ]
                [ input [ placeholder "Write something!" ] []
                ]
            , button [ class "btn btn--primary btn--icon" ]
                [ text "📬" ]
            ]
        ]
