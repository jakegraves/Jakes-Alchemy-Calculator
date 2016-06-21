module Toolbox.Update exposing (..)

import Dict
import Http
import Set
import Toolbox.Types exposing (Model, IngredientID, Response)


type Msg
    = DownloadedIngredients Response
    | DownloadFailed Http.Error
    | AddIngredient IngredientID
    | RemoveIngredient IngredientID
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        DownloadedIngredients maybeResponse ->
            responseToModel model maybeResponse ! []

        -- TODO: handle HTTP errors
        DownloadFailed _ ->
            model ! []

        AddIngredient id ->
            { model
                | selectedIds = Set.insert id model.selectedIds
            }
                ! []

        RemoveIngredient id ->
            { model | selectedIds = Set.remove id model.selectedIds } ! []

        NoOp ->
            model ! []


enumerate : List a -> List ( Int, a )
enumerate list =
    let
        ids =
            [1..(List.length list - 1)]
    in
        List.map2 (,) ids list


responseToModel : Model -> Response -> Model
responseToModel model response =
    { model | ingredients = enumerate response.ingredients |> Dict.fromList }
