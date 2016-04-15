module Toolbox.Types (..) where

import Dict
import Set


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
  , selectedIds : Set.Set IngredientID
  }


initialModel : Model
initialModel =
  { ingredients = Dict.empty
  , selectedIds = Set.empty
  }


selectedEffects : Model -> List String
selectedEffects model =
  Dict.filter (\id _ -> id `Set.member` model.selectedIds) model.ingredients
    |> Dict.values
    |> List.map (.effects)
    |> List.concat
    |> Set.fromList
    |> Set.toList
