module Aoc2
  ( solution
  ) where

import Prelude

import Data.Array (catMaybes, index)
import Data.Foldable (sum)
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), split)
import Data.Tuple (Tuple)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Node.Encoding (Encoding(..))
import Node.FS.Sync (readTextFile)

type Score =
  { mine :: HandShape
  , opponents :: HandShape
  }

data HandShape = Rock | Paper | Scissors

instance eqHandShape :: Eq HandShape where
  eq hs1 hs2 = case hs1 /\ hs2 of
    Rock /\ Rock -> true
    Paper /\ Paper -> true
    Scissors /\ Scissors -> true
    _ -> false

instance orderHandShape :: Ord HandShape where
  compare hs1 hs2 = case hs1 /\ hs2 of
    Rock /\ Rock -> EQ
    Rock /\ Paper -> LT
    Rock /\ Scissors -> GT
    Paper /\ Rock -> GT
    Paper /\ Paper -> EQ
    Paper /\ Scissors -> LT
    Scissors /\ Rock -> LT
    Scissors /\ Paper -> GT
    Scissors /\ Scissors -> EQ

solution :: Effect (Tuple Int Int)
solution = do
  i <- getInput
  pure $ (sum $ inputToScoreCount i) /\ (sum $ inputToScoreCount2 i)

getInput :: Effect String
getInput = readTextFile UTF8 "src/aoc2/aoc2.txt"

inputToScoreCount :: String -> Array Int
inputToScoreCount = split (Pattern "\n") >>> map toCode >>> map toScore >>> catMaybes >>> map countPoints

inputToScoreCount2 :: String -> Array Int
inputToScoreCount2 = split (Pattern "\n") >>> map toCode >>> map toScore2 >>> catMaybes >>> map countPoints

toCode :: String -> Tuple String String
toCode s = case scoreTuple of
  Just o /\ Just m -> o /\ m
  _ -> "" /\ ""
  where
  scoreTuple = (index (split (Pattern " ") s) 0) /\ (index (split (Pattern " ") s) 1)

toScore :: Tuple String String -> Maybe Score
toScore (s1 /\ s2) = case (toHandShape s1 /\ toHandShape s2) of
  Just hs1 /\ Just hs2 -> Just { opponents: hs1, mine: hs2 }
  _ -> Nothing
  where
  toHandShape :: String -> Maybe HandShape
  toHandShape s = case s of
    "A" -> Just Rock
    "B" -> Just Paper
    "C" -> Just Scissors
    "X" -> Just Rock
    "Y" -> Just Paper
    "Z" -> Just Scissors
    _ -> Nothing

toScore2 :: Tuple String String -> Maybe Score
toScore2 (s1 /\ s2) = case (toOpponentsHandShape s1 /\ toMyHandShape s1 s2) of
  Just hs1 /\ Just hs2 -> Just { opponents: hs1, mine: hs2 }
  _ -> Nothing
  where
  toOpponentsHandShape :: String -> Maybe HandShape
  toOpponentsHandShape s = case s of
    "A" -> Just Rock
    "B" -> Just Paper
    "C" -> Just Scissors
    _ -> Nothing

  toMyHandShape :: String -> String -> Maybe HandShape
  toMyHandShape opponents result = case result of
    "X" -> case opponents of -- lose
      "A" -> Just Scissors
      "B" -> Just Rock
      "C" -> Just Paper
      _ -> Nothing
    "Y" -> case opponents of -- draw
      "A" -> Just Rock
      "B" -> Just Paper
      "C" -> Just Scissors
      _ -> Nothing
    "Z" -> case opponents of -- win
      "A" -> Just Paper
      "B" -> Just Scissors
      "C" -> Just Rock
      _ -> Nothing
    _ -> Nothing

countPoints :: Score -> Int
countPoints score =
  let
    countBonusPoints handShape = case handShape of
      Rock -> 1
      Paper -> 2
      Scissors -> 3
    bonusPoints = countBonusPoints score.mine
  in
    case compare score.mine score.opponents of
      GT -> 6 + bonusPoints
      LT -> 0 + bonusPoints
      EQ -> 3 + bonusPoints