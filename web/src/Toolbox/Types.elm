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


type alias Recipe =
    { effects : Dict.Dict String Int }


type alias Model =
    { ingredients : Dict.Dict IngredientID Ingredient
    , selectedIds : Set.Set IngredientID
    , recipe : Recipe
    }


initialModel : Model
initialModel =
    { ingredients = Dict.empty
    , selectedIds = Set.empty
    , recipe = { effects = Dict.empty }
    }


updateRecipe : (Maybe Int -> Maybe Int) -> Recipe -> Ingredient -> Recipe
updateRecipe update recipe ingredient =
    { recipe
        | effects =
            List.foldl (\effect effects -> Dict.update effect update effects)
                recipe.effects
                ingredient.effects
    }


addIngredient : Recipe -> Ingredient -> Recipe
addIngredient =
    let
        incrementCounter : Maybe Int -> Maybe Int
        incrementCounter maybeX =
            case maybeX of
                Just x ->
                    Just (x + 1)

                Nothing ->
                    Just 1
    in
        updateRecipe incrementCounter


removeIngredient : Recipe -> Ingredient -> Recipe
removeIngredient =
    let
        decrementCounter : Maybe Int -> Maybe Int
        decrementCounter maybeX =
            case maybeX of
                Just x ->
                    if x > 1 then
                        Just (x - 1)
                    else
                        Nothing

                Nothing ->
                    Nothing
    in
        updateRecipe decrementCounter


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
