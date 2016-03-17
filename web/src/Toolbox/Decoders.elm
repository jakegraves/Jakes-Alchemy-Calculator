module Toolbox.Decoders where

import Json.Decode exposing ((:=), Decoder, string, int, float, list, object1, object4)

import Toolbox.Types exposing (Ingredient, Response)

ingredient : Decoder Ingredient
ingredient =
    object4 Ingredient
        ("name" := string)
        ("value" := int)
        ("weight" := float)
        ("effects" := list string)

response : Decoder Response
response =
    object1 Response ("ingredients" := list ingredient)

