module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { name : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { name = "" }, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = InputName String
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { name } =
            model
    in
    case msg of
        InputName n ->
            ( { model | name = n }, Cmd.none )

        Decrement ->
            ( { model | name = "b" }, Cmd.none )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Browser.Document Msg
view model =
    let
        { name } =
            model
    in
    { title = "onamae seal maker"
    , body =
        [ header [ class "site-header" ]
            [ h1 [] [ text "おなまえシールめーかー" ]
            ]
        , main_ []
            [ article
                []
                [ input [ onInput InputName ] []
                , button [ onClick Decrement ] [ text "-" ]
                ]
            ]
        ]
    }



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
