import 'dart:io';
import 'dart:math';

import 'package:adventofcode2021/day11.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
      """;

  test("Test Day 11 part 1", () {
    var lines = Day11Logic.parseInput(example);
    var result = Day11Logic.part1(lines);
    expect(result, 1656);
  });

  test("Test Day 11 part 2", () {
    var lines = Day11Logic.parseInput(example);
    var result = Day11Logic.part2(lines);
    expect(result, 195);
  });

  test("Day 11 actual puzzle input", () async {
    var input = await File('assets/Day11.txt').readAsString();

    var part1 = Day11Logic.part1(Day11Logic.parseInput(input));
    var part2 = Day11Logic.part2(Day11Logic.parseInput(input));

    print('Day 11');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
