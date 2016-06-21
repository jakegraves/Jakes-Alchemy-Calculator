module Toolbox.Views exposing (..)

import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Set
import Toolbox.Update exposing (Msg(..))
import Toolbox.Types exposing (Ingredient, IngredientID, Model, isSelected, commonEffects)


view : Model -> Html Msg
view model =
    case Dict.isEmpty model.ingredients of
        False ->
            div [ class "container" ]
                [ div [ class "row" ]
                    [ div [ class "col-sm-4" ]
                        [ div [ class "card" ]
                            [ div [ class "card-block" ]
                                [ h4 [ class "card-title" ] [ text "Ingredients" ] ]
                            , div [ class "list-group list-group-flush" ]
                                (model.ingredients |> Dict.toList |> List.map (ingredientItem model))
                            ]
                        ]
                    , div [ class "col-sm-8" ]
                        [ h2 [] [ text "Recipe (TODO)" ]
                        , ul [] (commonEffects model.recipe |> List.map effectItem)
                        ]
                    ]
                ]

        True ->
            div [ class "alert alert-info" ]
                [ text "Please wait..." ]


ingredientItem : Model -> ( IngredientID, Ingredient ) -> Html Msg
ingredientItem model ( id, i ) =
    a
        [ if id `isSelected` model then
            class "list-group-item active"
          else
            class "list-group-item"
        , href "#"
        , clickHandler
            (if id `isSelected` model then
                RemoveIngredient id
             else if Set.size model.selectedIds < 3 then
                AddIngredient id
             else
                NoOp
            )
        ]
        [ img [ src i.image, width 32, height 32 ] []
        , text i.name
        ]


effectItem : String -> Html Msg
effectItem effect =
    li [] [ text effect ]


clickHandler msg =
    onWithOptions "click"
        { stopPropagation = True, preventDefault = True }
        (Json.Decode.succeed msg)
