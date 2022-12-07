module Aoc1Part1
  ( solution
  ) where

import Prelude

import Data.Foldable (maximum, sum)
import Data.Int (fromString)
import Data.Maybe (fromMaybe)
import Data.String (Pattern(..), split)
import Effect (Effect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)

getInput :: Effect String
getInput = readTextFile UTF8 "src/aoc1/part1/aoc1part1.txt"

groupInput :: String -> Array String
groupInput = split (Pattern "\n\n")

getCalories :: Array String -> Array Int
getCalories calories = countCalories <$> calories
  where
  countCalories :: String -> Int
  countCalories c = sum $ fromMaybe 0 <$> (fromString <$> (split (Pattern "\n") c))

solution :: Effect Int
solution = do
  input <- getInput
  input # groupInput # getCalories # maximum # fromMaybe 0 # pure