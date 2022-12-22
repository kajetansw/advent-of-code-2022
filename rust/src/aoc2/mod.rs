use std::fs;

use itertools::Itertools;

pub fn aoc2() -> (String, String) {
  let input = fs::read_to_string("src/aoc2/aoc2.txt").unwrap();

  (
    sum_scores(&input, to_score).to_string(),
    sum_scores(&input, to_score2).to_string(),
  )
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

fn sum_scores<F>(input: &String, to_score_fn: F) -> i64
where
  F: Fn(&str) -> Score,
{
  input
    .lines()
    .into_iter()
    .map(to_score_fn)
    .map(count_points)
    .sum()
}

fn to_hand_shape(char: &str) -> HandShape {
  match char {
    "A" | "X" => HandShape::Rock,
    "B" | "Y" => HandShape::Paper,
    "C" | "Z" => HandShape::Scissors,
    _ => panic!("Unknown code found: {char}"),
  }
}

fn to_score(line: &str) -> Score {
  let tuple: Option<(HandShape, HandShape)> = line
    .split(" ")
    .into_iter()
    .map(to_hand_shape)
    .collect_tuple();

  match tuple {
    Some(t) => Score {
      opponents: t.0,
      mine: t.1,
    },
    None => panic!("Some line didn't have exactly 2 characters!"),
  }
}

fn to_score2(line: &str) -> Score {
  use HandShape::*;

  let string_tuple: (&str, &str) = line
    .split(" ")
    .into_iter()
    .collect_tuple()
    .expect("Some line didn't have exactly 2 characters!");

  fn to_my_hand_shape(opponents: &str, result: &str) -> HandShape {
    match result {
      "X" => match opponents {
        "A" => Scissors,
        "B" => Rock,
        "C" => Paper,
        _ => panic!("There was something else besides A, B and C in 1st column!"),
      },
      "Y" => match opponents {
        "A" => Rock,
        "B" => Paper,
        "C" => Scissors,
        _ => panic!("There was something else besides A, B and C in 1st column!"),
      },
      "Z" => match opponents {
        "A" => Paper,
        "B" => Scissors,
        "C" => Rock,
        _ => panic!("There was something else besides A, B and C in 1st column!"),
      },
      _ => panic!("There was something else besides X, Y, Z in 2nd column!"),
    }
  }

  Score {
    opponents: to_hand_shape(string_tuple.0),
    mine: to_my_hand_shape(string_tuple.0, string_tuple.1),
  }
}

fn count_points(score: Score) -> i64 {
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
