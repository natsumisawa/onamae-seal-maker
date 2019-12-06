module Main exposing (main)

import Browser
import Element exposing (Length, alignLeft, alpha, centerX, column, el, fill, fillPortion, image, layout, maximum, padding, px, rgba255, row, spacing, text, width)
import Element.Background exposing (color)
import Element.Border exposing (rounded)
import Element.Events exposing (onClick)
import Element.Font exposing (color, size)
import Element.Input exposing (labelHidden, placeholder, text)
import Html exposing (Html)
import Html.Attributes
import Html.Events



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { name : String
    , clickedIndexList : List Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { name = "", clickedIndexList = [] }, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = InputName String
    | OnClickButton Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { name, clickedIndexList } =
            model
    in
    case msg of
        InputName n ->
            ( { model | name = n }, Cmd.none )

        OnClickButton index ->
            ( { model
                | clickedIndexList =
                    if clickedIndexList |> List.member index then
                        clickedIndexList |> List.filter (\i -> i /= index)

                    else
                        index :: clickedIndexList
              }
            , Cmd.none
            )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Html Msg
view model =
    let
        { name, clickedIndexList } =
            model
    in
    layout [ Element.Background.color (rgba255 223 107 160 100) ] <|
        column [ padding 30, spacing 30, centerX ]
            [ el [ color (rgba255 255 255 255 100), centerX, size 40 ] (Element.text "おなまえシールめーかー")
            , Element.Input.text
                []
                { onChange = \n -> InputName n
                , text = name
                , placeholder = Just <| placeholder [] (Element.text "おなまえ")
                , label = labelHidden "text"
                }
            , row [ spacing 5 ] <|
                List.map
                    (\index ->
                        el
                            [ onClick <| OnClickButton index
                            , rounded 50
                            , padding 5
                            , Element.Background.color (rgba255 255 255 255 100)
                            ]
                        <|
                            image
                                [ width <| px 50
                                , if clickedIndexList |> List.member index then
                                    alpha 0.5

                                  else
                                    alpha 1
                                ]
                                { src = "assets/" ++ String.fromInt index ++ ".PNG"
                                , description = ""
                                }
                    )
                    (List.range 1 21)
            ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
