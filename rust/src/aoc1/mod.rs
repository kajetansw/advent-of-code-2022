use std::fs;

pub fn aoc1() -> (String, String) {
  let input = fs::read_to_string("src/aoc1/aoc1.txt").unwrap();

  let mut calories_per_elf = input_to_calories(input);
  calories_per_elf.sort_by(|a, b| b.cmp(a));

  let max_calorie_value: i64 = calories_per_elf.iter().take(1).sum();
  let sum_of_first_3: i64 = calories_per_elf.iter().take(3).sum();

  (max_calorie_value.to_string(), sum_of_first_3.to_string())
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
