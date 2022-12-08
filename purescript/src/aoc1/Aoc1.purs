module Aoc1
  ( solution
  ) where

import Prelude

import Data.Array (reverse, sort, take)
import Data.Foldable (sum)
import Data.Int (fromString)
import Data.Maybe (fromMaybe)
import Data.String (Pattern(..), split)
import Data.Tuple (Tuple)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)

getInput :: Effect String
getInput = readTextFile UTF8 "src/aoc1/aoc1.txt"

groupInput :: String -> Array (Array String)
groupInput input = split (Pattern "\n") <$> split (Pattern "\n\n") input

getCalories :: Array (Array String) -> Array Int
getCalories calories = countCalories <$> calories
  where
  parseCalorie :: String -> Int
  parseCalorie = fromMaybe 0 <<< fromString

  countCalories :: Array String -> Int
  countCalories c = sum $ parseCalorie <$> c

sumTopN :: Int -> Array Int -> Int
sumTopN n arr = sum $ take n arr

sortInput :: String -> Array Int
sortInput = groupInput >>> getCalories >>> sort >>> reverse

solution :: Effect (Tuple Int Int)
solution = do
  i <- getInput
  pure $ (sumTopN 1 $ sortInput i) /\ (sumTopN 3 $ sortInput i)