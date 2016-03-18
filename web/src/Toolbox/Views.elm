module Toolbox.Views (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Toolbox.Types exposing (Ingredient, Response)


view : Maybe Response -> Html
view response =
  case response of
    Just r ->
      ul
        [ class "list-group" ]
        (List.map ingredientItem r.ingredients)

    Nothing ->
      text "boo"


ingredientItem : Ingredient -> Html
ingredientItem i =
  li
    [ class "list-group-item" ]
    [ img [ src i.image, width 32, height 32 ] []
    , text i.name
    ]
