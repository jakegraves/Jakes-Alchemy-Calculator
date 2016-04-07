module Main (..) where

import Effects exposing (Effects, Never)
import Http
import StartApp
import Task
import Toolbox.Action exposing (Action(..), update)
import Toolbox.Decoders exposing (response)
import Toolbox.Types exposing (Model, initialModel)
import Toolbox.Views exposing (view)


downloadIngredients : Effects Action
downloadIngredients =
  Http.get response "/api/"
    |> Task.toMaybe
    |> Task.map DownloadedIngredients
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
