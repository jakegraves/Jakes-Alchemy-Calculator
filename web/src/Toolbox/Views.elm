module Toolbox.Views (..) where

import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Toolbox.Action exposing (Action(..))
import Toolbox.Types exposing (Ingredient, Model)


view : Signal.Address Action -> Model -> Html
view address model =
  case Dict.isEmpty model.ingredients of
    False ->
      div
        [ class "container" ]
        [ div
            [ class "row" ]
            [ div
                [ class "col-sm-4" ]
                [ div
                    [ class "card" ]
                    [ div
                        [ class "card-block" ]
                        [ h4 [ class "card-title" ] [ text "Ingredients" ] ]
                    , div
                        [ class "list-group list-group-flush" ]
                        (List.map (ingredientItem address) (Dict.values model.ingredients))
                    ]
                ]
            , div
                [ class "col-sm-8" ]
                [ h2 [] [ text "Recipe (TODO)" ] ]
            ]
        ]

    True ->
      div
        [ class "alert alert-info" ]
        [ text "Please wait..." ]


ingredientItem : Signal.Address Action -> Ingredient -> Html
ingredientItem address i =
  a
    [ class "list-group-item", href "#", clickHandler address NoOp ]
    [ img [ src i.image, width 32, height 32 ] []
    , text i.name
    ]


clickHandler address action =
  onWithOptions
    "click"
    { stopPropagation = True, preventDefault = True }
    Json.Decode.value
    (\_ -> Signal.message address action)
