module Main where

import Html exposing (text)
import Http
import Task exposing (Task, andThen)


results = Signal.mailbox ""

port tasks : Task Http.Error ()
port tasks =
    Http.getString "/api/" `andThen` Signal.send results.address

main =
    Signal.map text results.signal
