module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, section, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Random


main =
    Browser.element
        { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { content : String
    , face : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "" 1, Cmd.none )



-- UPDATE


type Msg
    = Change String
    | NewFace Int
    | Roll


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change value ->
            ( { model | content = value }, Cmd.none )

        NewFace value ->
            ( { model | face = value }, Cmd.none )

        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    section [ class "hero is-success is-fullheight" ]
        [ div [ class "hero-body" ]
            [ div [ class "container has-text-centered" ]
                [ div [ class "title is-1" ] [ text (String.fromInt model.face) ]
                , div [ class "subtitle is-2" ] [ text (String.reverse model.content) ]
                , input
                    [ class "input is-large has-text-centered is-focused"
                    , type_ "text"
                    , value model.content
                    , onInput Change
                    ]
                    []
                , button
                    [ class "button is-warning is-large"
                    , onClick Roll
                    ]
                    [ text "LANZAR DADO" ]
                ]
            ]
        ]
