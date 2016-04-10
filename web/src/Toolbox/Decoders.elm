module Toolbox.Decoders (..) where

import Json.Decode exposing ((:=), Decoder, string, int, float, list, succeed)
import Json.Decode.Extra exposing ((|:))
import Toolbox.Types exposing (Ingredient, Response)


ingredient : Decoder Ingredient
ingredient =
  succeed Ingredient
    |: ("name" := string)
    |: ("value" := int)
    |: ("weight" := float)
    |: ("image" := string)
    |: ("effects" := list string)


response : Decoder Response
response =
  succeed Response
    |: ("ingredients" := list ingredient)
