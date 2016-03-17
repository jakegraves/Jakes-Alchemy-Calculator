module Main where

import Http
import List
import Task exposing (Task, andThen, toMaybe)

import Toolbox.Decoders exposing (response)
import Toolbox.Types exposing (Ingredient, Response)
import Toolbox.Views exposing (view)


results : Signal.Mailbox (Maybe Response)
results = Signal.mailbox Nothing

port tasks : Task Http.Error ()
port tasks =
    toMaybe (Http.get response "/api/") `andThen` Signal.send results.address

main =
    Signal.map view results.signal
