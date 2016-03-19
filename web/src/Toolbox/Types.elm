module Toolbox.Types (..) where


type alias Ingredient =
  { name : String
  , value : Int
  , weight : Float
  , image : String
  , effects : List String
  }


type alias Response =
  { ingredients : List Ingredient
  }


type alias Model =
  { response : Maybe Response }


type Action
  = DownloadedIngredients (Maybe Response)
