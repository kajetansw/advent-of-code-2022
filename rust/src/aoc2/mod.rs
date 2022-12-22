use std::fs;

use itertools::Itertools;

pub fn aoc2() -> (String, String) {
  let input = fs::read_to_string("src/aoc2/aoc2.txt").unwrap();

  (sum_scores(input).to_string(), String::from("test"))
}

#[derive(PartialEq, Debug)]
enum HandShape {
  Rock = 1,
  Paper = 2,
  Scissors = 3,
}

struct Score {
  mine: HandShape,
  opponents: HandShape,
}

fn sum_scores(input: String) -> i64 {
  input
    .lines()
    .into_iter()
    .map(to_results)
    .map(to_score)
    .sum()
}

fn to_results(line: &str) -> Score {
  let tuple: Option<(HandShape, HandShape)> = line
    .split(" ")
    .into_iter()
    .map(|char| match char {
      "A" | "X" => HandShape::Rock,
      "B" | "Y" => HandShape::Paper,
      "C" | "Z" => HandShape::Scissors,
      _ => panic!("Unknown code found: {char}"),
    })
    .collect_tuple();

  match tuple {
    Some(t) => Score {
      opponents: t.0,
      mine: t.1,
    },
    None => panic!("Some line didn't have exactly 2 characters!"),
  }
}

fn to_score(score: Score) -> i64 {
  use HandShape::*;

  let bonus_points = match score.mine {
    Rock => 1,
    Paper => 2,
    Scissors => 3,
  };

  match score {
    Score {
      mine: Rock,
      opponents: Scissors,
    } => 6 + bonus_points,
    Score {
      mine: Paper,
      opponents: Rock,
    } => 6 + bonus_points,
    Score {
      mine: Scissors,
      opponents: Paper,
    } => 6 + bonus_points,
    _ => {
      if score.mine == score.opponents {
        3 + bonus_points
      } else {
        bonus_points
      }
    }
  }
}
