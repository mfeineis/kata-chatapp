module App.Page exposing (Intent(..), Model, view)

import App.Stream as Stream exposing (Stream, Topic)
import App.UI as UI exposing (ButtonModifier(..), PillModifier(..))
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
        [ UI.layout []
            [ UI.layoutContent []
                [ header model
                , UI.mainContent [ Attr.attribute "role" "main" ]
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
    UI.panelMenuHeader []
        [ UI.panelMenuTitle [] [ text "Almanac" ]
        , UI.panelMenuTextfield []
            [ input [ placeholder "What are you looking for?" ] []
            ]
        , UI.panelMenuMenu []
            [ UI.button [ IconButton ] []
                [ text "🍔"
                , UI.pill [ PrimaryPill, SupPill ] [] [ text "3" ]
                ]
            ]
        ]


toolPanel _ =
    UI.toolPanel []
        [ UI.toolPanelItems []
            [ UI.toolPanelItem []
                [ UI.button [ IconButton ] []
                    [ text "\u{1F9EA}"
                    ]
                ]
            , UI.toolPanelItem []
                [ UI.button [ IconButton ] []
                    [ text "👔"
                    , UI.pill [ SupPill ] [] [ text "1" ]
                    ]
                ]
            , UI.toolPanelItem []
                [ UI.button [ IconButton ] []
                    [ text "👕"
                    ]
                ]
            , UI.toolPanelItem []
                [ UI.button [ IconButton ] []
                    [ text "👗"
                    ]
                ]
            ]
        , UI.toolPanelTools []
            [ UI.toolPanelItem []
                [ UI.button [ IconButton ] []
                    [ text "⚙️"
                    ]
                ]
            ]
        ]


toolPanelMenu _ =
    UI.toolPanelMenu []
        [ UI.toolPanelItems []
            [ UI.toolPanelItem []
                [ UI.menuEntry []
                    [ UI.menuEntryIcon [] [ text "\u{1F9F6}" ]
                    , UI.menuEntryLabel [] [ text "Do Something" ]
                    ]
                ]
            , UI.toolPanelItem []
                [ UI.menuEntry []
                    [ UI.menuEntryIcon [] [ text "\u{1F9F8}" ]
                    , UI.menuEntryLabel [] [ text "Do Another Thing" ]
                    ]
                ]
            ]
        , UI.toolPanelTools []
            [ UI.toolPanelItem []
                [ UI.menuEntry []
                    [ UI.menuEntryIcon [] [ text "\u{1F97C}" ]
                    , UI.menuEntryLabel [] [ text "Experimental" ]
                    ]
                ]
            ]
        ]



-- STREAMS


streamPanel : { a | streams : List Stream } -> Html Intent
streamPanel { streams } =
    UI.toolPanelMenu []
        [ UI.toolPanelItems []
            (List.map streamItem streams)
        ]


streamItem : Stream -> Html Intent
streamItem stream =
    UI.toolPanelItem []
        [ UI.streamItemHighlighted []
            [ UI.streamItemIcon [] [ text "💢" ]
            , UI.streamItemLabel [] [ text (Stream.name stream) ]
            , span []
                [ UI.pill [ InlinePill, PrimaryPill ]
                    []
                    [ text "1" ]
                ]
            ]
        , UI.toolPanelItems []
            (List.map topicItem (Stream.topics stream))
        ]


topicItem : Topic -> Html Intent
topicItem name =
    UI.toolPanelItem []
        [ UI.streamItemSub []
            [ UI.streamItemIcon [] [ text "📎" ]
            , UI.streamItemLabel [] [ text (Stream.topicName name) ]
            ]
        ]



-- DETAILS


detailPanel : a -> Html Intent
detailPanel _ =
    UI.detailPanel []
        [ UI.panelMenu []
            [ UI.panelMenuSpacing [] []
            , UI.panelMenuMenu []
                [ UI.button [ IconButton ] []
                    [ text "🍔"
                    ]
                ]
            ]
        , UI.panelContent []
            [ text "Details..."
            , UI.button [ PrimaryButton ] [ disabled True ]
                [ text "A disabled button" ]
            , text "Some more text and finally"
            , UI.button [ PrimaryButton ] []
                [ text "An active button" ]
            , UI.button [ PrimaryButton, SmallButton ] []
                [ text "A small button" ]
            , UI.button [ LargeButton, PrimaryButton ] []
                [ text "A large button" ]
            ]
        ]



-- THREADS


threadPanel : a -> Html Intent
threadPanel _ =
    UI.threadPanel []
        [ UI.panelMenu []
            [ li []
                [ UI.button [ IconButton ] [ disabled True ]
                    [ text "🖌"
                    ]
                ]
            , li []
                [ UI.button [ IconButton, PrimaryButton ] []
                    [ text "💡"
                    ]
                ]
            , UI.panelMenuTitle []
                [ text "Conversation"
                ]
            , UI.panelMenuSpacing [] []
            , UI.panelMenuMenu []
                [ UI.button [ IconButton ] []
                    [ text "🐣"
                    ]
                ]
            ]
        , UI.panelContent []
            [ text "Content"
            ]
        , UI.panelMenuFooter []
            [ UI.panelMenuTextfield []
                [ input [ placeholder "Write something!" ] []
                ]
            , UI.button [ IconButton, PrimaryButton ] []
                [ text "📬" ]
            ]
        ]
