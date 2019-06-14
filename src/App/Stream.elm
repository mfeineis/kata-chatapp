module App.Stream exposing (Stream, Topic, mocked, name, topicName, topics)


type Stream
    = Stream String (List Topic)


type Topic
    = Topic String


mocked =
    [ Stream "general"
        [ Topic "elm-conf"
        , Topic "elm-in-the-spring"
        , Topic "elm-conf-europe"
        ]
    , Stream "random"
        [ Topic "we-want-typeclasses"
        , Topic "we-need-native-code"
        ]
    ]


name (Stream n _) =
    n


topics (Stream _ ts) =
    ts


topicName (Topic n) =
    n
