module Main where

import Html exposing (Html, text)
import Http
import Json.Decode exposing ((:=), Decoder, string, int, float, list, object1, object4)
import Task exposing (Task, andThen, toMaybe)


results : Signal.Mailbox (Maybe Response)
results = Signal.mailbox Nothing

port tasks : Task Http.Error ()
port tasks =
    toMaybe (Http.get response "/api/") `andThen` Signal.send results.address

view : Maybe Response -> Html
view response =
    case response of
        Just r -> text "yay"
        Nothing -> text "boo"

main =
    Signal.map view results.signal

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
