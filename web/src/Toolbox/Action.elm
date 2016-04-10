module Toolbox.Action (..) where

import Dict
import Effects exposing (Effects)
import Toolbox.Types exposing (Model, Response)


type Action
  = DownloadedIngredients (Maybe Response)
  | NoOp


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    DownloadedIngredients maybeResponse ->
      ( responseToModel maybeResponse
      , Effects.none
      )

    NoOp ->
      ( model, Effects.none )


enumerate : List a -> List ( Int, a )
enumerate list =
  let
    ids =
      [1..(List.length list - 1)]
  in
    List.map2 (,) ids list


responseToModel : Maybe Response -> Model
responseToModel maybeResponse =
  case maybeResponse of
    Just r ->
      { ingredients = enumerate r.ingredients |> Dict.fromList }

    Nothing ->
      { ingredients = Dict.empty }
