module Main where

import Prelude

import Aoc1 as Aoc1
import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  aoc1Solution <- Aoc1.solution
  log $ "Solution #1: " <> show aoc1Solution