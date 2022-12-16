use std::fs;
use std::io::Error;

pub fn aoc1() -> (String, String) {
  let input = get_input();
  let calories_per_elf = input.map(input_to_calories);
  let max_calorie_value = calories_per_elf
    .map(|val| val.into_iter().max().unwrap_or(0))
    .unwrap_or(0);

  (max_calorie_value.to_string(), String::from("Solution 1-2"))
}

fn get_input() -> Result<String, Error> {
  fs::read_to_string("src/aoc1/aoc1.txt")
}

fn input_to_calories(input: String) -> Vec<i64> {
  input
    .split("\n\n")
    .into_iter()
    .map(|per_elf| {
      per_elf
        .lines()
        .map(|line| line.parse::<i64>().unwrap_or(0))
        .sum()
    })
    .collect::<Vec<i64>>()
}
