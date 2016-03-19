module Toolbox.Action (..) where

import Effects exposing (Effects)
import Toolbox.Types exposing (Model, Response)


type Action
  = DownloadedIngredients (Maybe Response)


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    DownloadedIngredients maybeResponse ->
      ( { model | response = maybeResponse }
      , Effects.none
      )
