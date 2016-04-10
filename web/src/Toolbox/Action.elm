module Toolbox.Action (..) where

import Dict
import Set
import Effects exposing (Effects)
import Toolbox.Types exposing (Model, IngredientID, Response)


type Action
  = DownloadedIngredients (Maybe Response)
  | SelectIngredient IngredientID
  | NoOp


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    DownloadedIngredients maybeResponse ->
      ( responseToModel model maybeResponse
      , Effects.none
      )

    SelectIngredient id ->
      ( { model | selectedIds = updateIds id model.selectedIds }
      , Effects.none
      )

    NoOp ->
      ( model, Effects.none )


updateIds : IngredientID -> Set.Set IngredientID -> Set.Set IngredientID
updateIds id selectedIds =
  if Set.member id selectedIds then
    Set.remove id selectedIds
  else if Set.size selectedIds < 4 then
    Set.insert id selectedIds
  else
    selectedIds


enumerate : List a -> List ( Int, a )
enumerate list =
  let
    ids =
      [1..(List.length list - 1)]
  in
    List.map2 (,) ids list


responseToModel : Model -> Maybe Response -> Model
responseToModel model maybeResponse =
  case maybeResponse of
    Just r ->
      { model | ingredients = enumerate r.ingredients |> Dict.fromList }

    Nothing ->
      { model | ingredients = Dict.empty }
