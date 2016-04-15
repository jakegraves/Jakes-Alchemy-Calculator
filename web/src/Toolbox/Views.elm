module Toolbox.Views (..) where

import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Toolbox.Action exposing (Action(..))
import Toolbox.Types exposing (Ingredient, IngredientID, Model, isSelected, selectedEffects)


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
                        (List.map (ingredientItem model address) (Dict.toList model.ingredients))
                    ]
                ]
            , div
                [ class "col-sm-8" ]
                [ h2 [] [ text "Recipe (TODO)" ]
                , ul [] (selectedEffects model |> List.map effectItem)
                ]
            ]
        ]

    True ->
      div
        [ class "alert alert-info" ]
        [ text "Please wait..." ]


ingredientItem : Model -> Signal.Address Action -> ( IngredientID, Ingredient ) -> Html
ingredientItem model address ( id, i ) =
  a
    [ if id `isSelected` model then
        class "list-group-item active"
      else
        class "list-group-item"
    , href "#"
    , clickHandler address (SelectIngredient id)
    ]
    [ img [ src i.image, width 32, height 32 ] []
    , text i.name
    ]


effectItem : String -> Html
effectItem effect =
  ul [] [ text effect ]


clickHandler address action =
  onWithOptions
    "click"
    { stopPropagation = True, preventDefault = True }
    Json.Decode.value
    (\_ -> Signal.message address action)
