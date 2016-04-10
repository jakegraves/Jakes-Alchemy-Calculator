module Toolbox.Action (..) where

import Dict
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
      ( model, Effects.none )

    NoOp ->
      ( model, Effects.none )


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
