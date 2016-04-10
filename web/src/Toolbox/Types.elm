module Toolbox.Types (..) where

import Dict


type alias Ingredient =
  { name : String
  , value : Int
  , weight : Float
  , image : String
  , effects : List String
  }


type alias IngredientID =
  Int


type alias Response =
  { ingredients : List Ingredient
  }


type alias Model =
  { ingredients : Dict.Dict IngredientID Ingredient
  , selectedIds : List IngredientID
  }


initialModel : Model
initialModel =
  { ingredients = Dict.empty
  , selectedIds = []
  }
