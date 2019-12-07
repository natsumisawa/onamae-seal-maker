module Main exposing (main)

import Browser
import Element exposing (Length, alignLeft, alpha, centerX, column, el, fill, fillPortion, image, layout, maximum, padding, px, rgba255, row, spacing, text, width, wrappedRow)
import Element.Background exposing (color)
import Element.Border exposing (rounded)
import Element.Events exposing (onClick)
import Element.Font exposing (color, size)
import Element.Input exposing (button, labelHidden, placeholder, text)
import Html exposing (Html)
import Html.Attributes
import Html.Events



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { name : String
    , selectedLR : LeftOrRight
    , clickedIndexListLeft : List Int
    , clickedIndexListRight : List Int
    , isFinishedChoice : Bool
    }


type LeftOrRight
    = Left
    | Right


init : () -> ( Model, Cmd Msg )
init _ =
    ( { name = "", selectedLR = Left, clickedIndexListLeft = [], clickedIndexListRight = [], isFinishedChoice = False }, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = InputName String
    | OnClickLeftButton
    | OnClickRightButton
    | OnClickButton Int
    | GenerateSeal


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { name, selectedLR, clickedIndexListLeft, clickedIndexListRight } =
            model
    in
    case msg of
        InputName n ->
            ( { model | name = n }, Cmd.none )

        OnClickButton index ->
            case selectedLR of
                Left ->
                    ( { model
                        | clickedIndexListLeft =
                            if clickedIndexListLeft |> List.member index then
                                clickedIndexListLeft |> List.filter (\i -> i /= index)

                            else if List.length clickedIndexListLeft >= 4 then
                                clickedIndexListLeft

                            else
                                index :: clickedIndexListLeft
                      }
                    , Cmd.none
                    )

                Right ->
                    ( { model
                        | clickedIndexListRight =
                            if clickedIndexListRight |> List.member index then
                                clickedIndexListRight |> List.filter (\i -> i /= index)

                            else if List.length clickedIndexListRight >= 4 then
                                clickedIndexListRight

                            else
                                index :: clickedIndexListRight
                      }
                    , Cmd.none
                    )

        GenerateSeal ->
            ( { model
                | isFinishedChoice = True
              }
            , Cmd.none
            )

        OnClickLeftButton ->
            ( { model
                | selectedLR = Left
              }
            , Cmd.none
            )

        OnClickRightButton ->
            ( { model
                | selectedLR = Right
              }
            , Cmd.none
            )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Html Msg
view model =
    let
        { name, selectedLR, clickedIndexListLeft, clickedIndexListRight, isFinishedChoice } =
            model
    in
    layout [ Element.Background.color (rgba255 223 107 160 100) ] <|
        column [ padding 30, spacing 30, centerX, width (px 320) ]
            [ el [ size 25, color white, centerX ] (Element.text "おなまえシールめーかー")
            , row [ spacing 3, centerX, width (px 320) ]
                [ button
                    [ case selectedLR of
                        Left ->
                            Element.Background.color
                                (rgba255 103 182 166 100)

                        Right ->
                            Element.Background.color
                                (rgba255 220 220 220 100)
                    , rounded 50
                    , padding 10
                    , centerX
                    , color white
                    ]
                    { onPress = Just OnClickLeftButton
                    , label = Element.text "←"
                    }
                , Element.Input.text []
                    { onChange = \n -> InputName n
                    , text = name
                    , placeholder = Just <| placeholder [] (Element.text "おなまえ")
                    , label = labelHidden "name"
                    }
                , button
                    [ case selectedLR of
                        Left ->
                            Element.Background.color
                                (rgba255 220 220 220 100)

                        Right ->
                            Element.Background.color
                                (rgba255 103 182 166 100)
                    , rounded 50
                    , padding 10
                    , centerX
                    , color white
                    ]
                    { onPress = Just OnClickRightButton
                    , label = Element.text "→"
                    }
                ]
            , if (List.length clickedIndexListLeft >= 4) || (List.length clickedIndexListRight >= 84) then
                el [ size 12, color white, centerX ] <| Element.text "それぞれ4つまでしか選べません！"

              else
                Element.none
            , case selectedLR of
                Left ->
                    buttonsView clickedIndexListLeft

                Right ->
                    buttonsView clickedIndexListRight

            -- , button
            --     [ Element.Background.color (rgba255 103 182 166 100)
            --     , rounded 50
            --     , padding 10
            --     , centerX
            --     , color white
            --     ]
            --     { onPress = Just GenerateSeal
            --     , label = Element.text "つくる"
            --     }
            , -- if isFinishedChoice then
              row [ centerX, Element.Background.color white ] <|
                List.append
                    ((Element.text name
                        :: List.map
                            (\i ->
                                el [] <|
                                    image
                                        [ width <| px 30 ]
                                        { src = "assets/" ++ String.fromInt i ++ ".PNG"
                                        , description = ""
                                        }
                            )
                            clickedIndexListLeft
                     )
                        |> List.reverse
                    )
                <|
                    List.map
                        (\i ->
                            el [] <|
                                image
                                    [ width <| px 30 ]
                                    { src = "assets/" ++ String.fromInt i ++ ".PNG"
                                    , description = ""
                                    }
                        )
                        clickedIndexListRight

            -- else
            --   Element.none
            ]


white : Element.Color
white =
    rgba255 255 255 255 100


buttonsView : List Int -> Element.Element Msg
buttonsView clickedIndexList =
    wrappedRow [ centerX, spacing 3, width (px 320) ] <|
        List.map
            (\i ->
                el
                    [ rounded 50
                    , padding 5
                    , Element.Background.color white
                    , onClick <| OnClickButton i
                    ]
                <|
                    image
                        [ width <| px 30
                        , if clickedIndexList |> List.member i then
                            alpha 0.5

                          else
                            alpha 1
                        ]
                        { src = "assets/" ++ String.fromInt i ++ ".PNG"
                        , description = ""
                        }
            )
            (List.range 1 21)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
