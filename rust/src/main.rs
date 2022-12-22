pub mod aoc1;
pub mod aoc2;

fn main() {
  print_day(1, aoc1::aoc1());
  print_day(2, aoc2::aoc2());
}

fn print_day<A>(day_num: usize, solution: A)
where
  A: std::fmt::Debug,
{
  println!("Day #{day_num}:");
  println!("{:?}", solution);
  println!("");
}
