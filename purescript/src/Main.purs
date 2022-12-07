module Main where

import Prelude

import Aoc1Part1 as Aoc1Part1
import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  aoc1Part1Solution <- Aoc1Part1.solution
  log $ "Solution #1-1: " <> show aoc1Part1Solution