module Main where

import Prelude

import Aoc1 as Aoc1
import Aoc2 as Aoc2
import Aoc3 as Aoc3
import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
  aoc1Solution <- Aoc1.solution
  aoc2Solution <- Aoc2.solution
  aoc3Solution <- Aoc3.solution
  log $ logSolution 1 $ show aoc1Solution
  log $ logSolution 2 $ show aoc2Solution
  log $ logSolution 3 $ show aoc3Solution

logSolution :: Int -> String -> String
logSolution n s = "Day #" <> show n <> ":\n" <> show s <> "\n"