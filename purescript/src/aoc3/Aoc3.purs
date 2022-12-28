module Aoc3
  ( solution
  ) where

import Prelude

import Data.Char (toCharCode)
import Data.Foldable (sum)
import Data.List (List(..), elemIndex, fromFoldable, length, (:))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), split)
import Data.String.CodeUnits (toCharArray)
import Data.Tuple (Tuple)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)

solution :: Effect (Tuple Int Int)
solution = do
  i <- getInput
  pure $ (getSumOfPriorities i) /\ 1

getInput :: Effect String
getInput = readTextFile UTF8 "src/aoc3/aoc3.txt"

getSumOfPriorities :: String -> Int
getSumOfPriorities = split (Pattern "\n") >>> map toCharList >>> map splitToComparments >>> map findSharedItem >>> map toPriority >>> sum

splitToComparments :: List Char -> Tuple (List Char) (List Char)
splitToComparments items = go Nil items
  where
  go :: List Char -> List Char -> Tuple (List Char) (List Char)
  go Nil (l2 : ls2) = go (l2 : Nil) ls2
  go _ Nil = Nil /\ Nil
  go x1 x2@(l2 : ls2) = if length x1 == length x2 then x1 /\ x2 else go (l2 : x1) ls2

toCharList :: String -> List Char
toCharList s = fromFoldable $ toCharArray s

-- fromCharList :: List Char -> String
-- fromCharList = foldl (\accum a -> accum <> singleton a) ""

findSharedItem :: Tuple (List Char) (List Char) -> Char
findSharedItem (Nil /\ _) = '?'
findSharedItem (_ /\ Nil) = '?'
findSharedItem ((c1 : cs1) /\ chars2) = case elemIndex c1 chars2 of
  Nothing -> findSharedItem (cs1 /\ chars2)
  Just _ -> c1

toPriority :: Char -> Int
toPriority c = case c of
  _ | toCharCode c >= 97 && toCharCode c <= 122 -> toCharCode c - 97 + 1 -- from 'a' to 'z'
  _ | toCharCode c >= 65 && toCharCode c <= 90 -> toCharCode c - 65 + 27 -- from 'A' to 'Z'
  _ -> 0