module Toolbox.Update exposing (..)

import Dict
import Http
import Set
import Toolbox.Types exposing (Model, IngredientID, Response)


type Msg
    = DownloadedIngredients Response
    | DownloadFailed Http.Error
    | SelectIngredient IngredientID
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        DownloadedIngredients maybeResponse ->
            ( responseToModel model maybeResponse
            , Cmd.none
            )

        -- TODO: handle HTTP errors
        DownloadFailed _ ->
            ( model, Cmd.none )

        SelectIngredient id ->
            ( { model | selectedIds = updateIds id model.selectedIds }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )


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


responseToModel : Model -> Response -> Model
responseToModel model response =
    { model | ingredients = enumerate response.ingredients |> Dict.fromList }
