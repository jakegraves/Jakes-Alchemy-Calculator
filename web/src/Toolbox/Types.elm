module Toolbox.Types exposing (..)

import Dict
import Set
import List.Extra exposing (group)


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


isSelected : IngredientID -> Model -> Bool
isSelected id model =
    id `Set.member` model.selectedIds


commonEffects : Model -> List String
commonEffects model =
    Dict.filter (\id _ -> id `isSelected` model) model.ingredients
        |> Dict.values
        |> List.map (.effects)
        |> List.concat
        |> List.sort
        |> group
        |> List.filterMap
            (\sublist ->
                if List.length sublist > 1 then
                    List.head sublist
                else
                    Nothing
            )
