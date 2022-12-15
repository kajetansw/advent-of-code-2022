pub mod aoc1;

fn main() {
  print_day(1, aoc1::aoc1());
}

fn print_day<A>(day_num: usize, solution: A)
where
  A: std::fmt::Debug,
{
  println!("!!! Day {day_num} !!!");
  println!("{:?}", solution);
}
