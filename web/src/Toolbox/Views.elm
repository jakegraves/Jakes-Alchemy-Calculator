module Toolbox.Views (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Toolbox.Action exposing (Action)
import Toolbox.Types exposing (Ingredient, Model)


view : Signal.Address Action -> Model -> Html
view address model =
  case model.response of
    Just r ->
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
                        (List.map ingredientItem r.ingredients)
                    ]
                ]
            , div
                [ class "col-sm-8" ]
                [ h2 [] [ text "Recipe (TODO)" ] ]
            ]
        ]

    Nothing ->
      div
        [ class "alert alert-info" ]
        [ text "Please wait..." ]


ingredientItem : Ingredient -> Html
ingredientItem i =
  a
    [ class "list-group-item", href "#" ]
    [ img [ src i.image, width 32, height 32 ] []
    , text i.name
    ]
