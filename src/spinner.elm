module Spinner exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
-- import Html.Attributes exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)

type alias Model = { value : Int }
type alias Msg = { }

view : Model -> Html Msg
view model = 
  Svg.svg [viewBox "-200 -200 400 400", width "400px", height "400px"] 
    [ Svg.circle [ fill "blue", cx "0", cy "0", r "200" ] [] 
    , Svg.polygon [ points "10,20 -10,20 0,-20 10,20", stroke "orange", strokeWidth "3", fill "none", strokeLinejoin "round"] []
    ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  ( model, Cmd.none )

initialModel : Model
initialModel = { value = 1 }

main =
  Html.program
    { init = ( initialModel, Cmd.none )
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }





