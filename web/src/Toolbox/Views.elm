module Toolbox.Views (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Toolbox.Types exposing (Response)


view : Maybe Response -> Html
view response =
  case response of
    Just r ->
      ul
        []
        (List.map
          (\i ->
            li
              []
              [ img [ src i.image, width 32, height 32 ] []
              , text i.name
              ]
          )
          r.ingredients
        )

    Nothing ->
      text "boo"
