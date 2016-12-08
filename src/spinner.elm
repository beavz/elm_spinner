module Spinner exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time)
import Random


type alias Model =
    { theta : Int
    , oomph : Int
    }


type Msg
    = RequestSpinMagnitude
    | ReceiveSpinMagnitude Int
    | MSPassed Time


view : Model -> Html Msg
view model =
    Svg.svg [ viewBox "-200 -200 400 400", width "400px", height "400px" ]
        [ Svg.circle [ fill "blue", cx "0", cy "0", r "200", onClick RequestSpinMagnitude ] []
        , Svg.polygon [ points "10,20 -10,20 0,-100 10,20"
            , stroke "orange"
            , strokeWidth "3"
            , fill "none"
            , strokeLinejoin "round"
            , transform (String.concat [ "rotate(", (toString model.theta), " 0 0)" ])
            ]
            []
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestSpinMagnitude ->
            ( model, Random.generate ReceiveSpinMagnitude (Random.int 100 500) )

        ReceiveSpinMagnitude mag ->
            ( { model | oomph = model.oomph + mag }, Cmd.none )

        MSPassed _ ->
            if model.oomph > 0 then
                ( { model | theta = model.theta + 1, oomph = model.oomph - 1 }, Cmd.none )
            else
                ( model, Cmd.none )


initialModel : Model
initialModel =
    { theta = 0
    , oomph = 0
    }


subscriptions : Model -> Sub Msg
subscriptions { theta, oomph } =
    if oomph > 0 then
        Time.every Time.millisecond MSPassed
    else
        Sub.none


main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
