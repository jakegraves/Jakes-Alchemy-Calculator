module Main (..) where

import Effects exposing (Effects, Never)
import Http
import List
import StartApp
import Task exposing (Task, andThen, toMaybe)
import Toolbox.Decoders exposing (response)
import Toolbox.Types exposing (Action, Ingredient, Response, Model)
import Toolbox.Views exposing (view)


initialModel : Model
initialModel =
  { response = Nothing }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    Toolbox.Types.DownloadedIngredients maybeResponse ->
      ( { model | response = maybeResponse }
      , Effects.none
      )


downloadIngredients : Effects Action
downloadIngredients =
  Http.get response "/api/"
    |> Task.toMaybe
    |> Task.map Toolbox.Types.DownloadedIngredients
    |> Effects.task


app =
  StartApp.start
    { init = ( initialModel, downloadIngredients )
    , update = update
    , view = view
    , inputs = []
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
