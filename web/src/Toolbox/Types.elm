module Toolbox.Types where

type alias Ingredient =
    { name : String
    , value : Int
    , weight : Float
    , effects : List String
    }

type alias Response =
    { ingredients : List Ingredient
    }
