module Toolbox.Views (..) where

import Html exposing (Html, ul, li, text)
import Toolbox.Types exposing (Response)


view : Maybe Response -> Html
view response =
  case response of
    Just r ->
      ul
        []
        (List.map (\i -> li [] [ text i.name ]) r.ingredients)

    Nothing ->
      text "boo"
