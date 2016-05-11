module Main exposing (..)

import Html.App as Html
import Http
import Task
import Toolbox.Decoders exposing (response)
import Toolbox.Types exposing (Model, initialModel)
import Toolbox.Update exposing (Msg(..), update)
import Toolbox.Views exposing (view)


downloadIngredients : Cmd Msg
downloadIngredients =
    Http.get response "/api/"
        |> Task.perform DownloadFailed DownloadedIngredients


main =
    Html.program
        { init = ( initialModel, downloadIngredients )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
