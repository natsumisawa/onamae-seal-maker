module Main exposing (main)

import Browser
import Element exposing (centerX, el, layout, padding, rgba255)
import Element.Background exposing (color)
import Element.Font exposing (color)
import Element.Input exposing (..)
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
        [ Element.layout [ Element.Background.color (rgba255 223 107 160 100), Element.Font.color (rgba255 255 255 255 100) ] <|
            Element.row [ centerX, padding 30 ]
                [ Element.el [] (Element.text "おなまえシールめ〜か〜")
                ]
        ]

    -- [ header [ class "site-header" ]
    --     [ h1 [] [ Html.text "おなまえシールめーかー" ]
    --     ]
    -- , main_ []
    --     [ article
    --         []
    --         [ Element.layout [] <|
    --             Element.Input.text
    --                 []
    --                 { onChange = \n -> InputName n
    --                 , text = name
    --                 , placeholder = Nothing
    --                 , label = Element.Input.labelHidden "text"
    --                 }
    --         ]
    --     ]
    -- ]
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
