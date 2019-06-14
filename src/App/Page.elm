module App.Page exposing (Intent(..), Model, view)

import App.Stream as Stream exposing (Stream, Topic)
import Browser
import Html exposing (Html, div, li, ol, span, text)
import Html.Attributes as Attr


type alias Model =
    { streams : List Stream
    }


type Intent
    = NoOp


view : Model -> Browser.Document Intent
view model =
    { title = "Chat"
    , body =
        [ streamPanel model
        , detailPanel model
        , threadPanel model
        ]
    }



-- STREAMS


streamPanel : { a | streams : List Stream } -> Html Intent
streamPanel { streams } =
    ol []
        (List.map streamItem streams)


streamItem : Stream -> Html Intent
streamItem stream =
    li []
        [ text (Stream.name stream)
        , ol []
            (List.map topicItem (Stream.topics stream))
        ]


topicItem : Topic -> Html Intent
topicItem name =
    li []
        [ text (Stream.topicName name)
        ]



-- DETAILS


detailPanel : a -> Html Intent
detailPanel _ =
    div []
        [ text "Details..."
        ]



-- THREADS


threadPanel : a -> Html Intent
threadPanel _ =
    div []
        [ text "Content"
        ]
