port module Main exposing (main)

import Browser exposing (..)
import Html exposing (..)
import Html.Events exposing (..)


main : Program Model Model Msg
main =
    element
        { init = \flags -> ( flags, Cmd.none )
        , view = view
        , update = update
        , subscriptions = always <| getValue Get
        }


type Msg
    = NoOp
    | Get (List String)
    | Del Int


type alias Model =
    List String


view : Model -> Html Msg
view model =
    div []
        [ model
            |> List.indexedMap Tuple.pair
            |> List.map listItem
            |> ul []
        ]

listItem : (Int, String) -> Html Msg
listItem (i, str) =
    li []
        [ text str
        , button [ onClick <| Del i ] [ text "x" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Get str ->
            ( str, Cmd.none )

        Del index ->
            let
                newModel =
                    model
                        |> List.indexedMap Tuple.pair
                        |> List.filter (Tuple.first >> (/=) index)
                        |> List.map Tuple.second
            in
            ( newModel
            , sendValue newModel
            )

        NoOp ->
            ( model, Cmd.none )


port getValue : (List String -> msg) -> Sub msg
port sendValue : List String -> Cmd msg