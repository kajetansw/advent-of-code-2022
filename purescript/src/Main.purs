module Main where

import Prelude

import Aoc1 as Aoc1
import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  log $ Aoc1.solution
