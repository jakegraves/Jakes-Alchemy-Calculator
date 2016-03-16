module Main where

import Html exposing (text)
import Http
import Json.Decode exposing ((:=), Decoder, string, int, float, list, object1, object4)
import Task exposing (Task, andThen)


results : Signal.Mailbox String
results = Signal.mailbox ""

port tasks : Task Http.Error ()
port tasks =
    Http.getString "/api/" `andThen` Signal.send results.address

main =
    Signal.map text results.signal

type alias Ingredient =
    { name : String
    , value : Int
    , weight : Float
    , effects : List String
    }

type alias Response =
    { ingredients : List Ingredient
    }

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
