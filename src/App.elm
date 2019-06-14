module App exposing (main)

import App.Page as Page exposing (Intent(..), Model)
import App.Stream as Stream
import Browser
import Html
import Json.Decode exposing (Value)
import Task


type Msg
    = Fact Fact
    | Intent Intent


type Fact
    = NoFact


init : Value -> ( Model, Cmd Msg )
init flags =
    withCmds []
        { streams = Stream.mocked
        }


apply : Fact -> Model -> ( Model, Cmd Msg )
apply fact model =
    withCmds [] model


interpret : Intent -> Model -> ( Model, Cmd Msg )
interpret intent model =
    withCmds [] model



-- UTILS


main : Program Value Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = \_ -> Sub.none
        , update =
            \msg model ->
                case msg of
                    Fact fact ->
                        apply fact model

                    Intent intent ->
                        interpret intent model
        , view =
            \model ->
                let
                    { title, body } =
                        Page.view model
                in
                { title = title
                , body = List.map (Html.map Intent) body
                }
        }


withCmds : List (Cmd msg) -> model -> ( model, Cmd msg )
withCmds cmds model =
    ( model, Cmd.batch cmds )


toCmd : msg -> Cmd msg
toCmd msg =
    Task.perform identity (Task.succeed msg)
