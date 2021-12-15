import 'dart:io';

import 'package:adventofcode2021/Day7.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      16,1,2,0,4,2,7,1,2,14
      """;

  test("Test Day 7 part 1", () {
    var lines = Day7Logic.parseInput(example);
    var result = Day7Logic.part1(lines);
    expect(result, 37);
  });

  test("Test Day 7 part 2", () {
    var lines = Day7Logic.parseInput(example);
    var result = Day7Logic.part2(lines);
    expect(result, 168);
  });

  test("Day 7 actual puzzle input", () async {
    var input = await File('assets/day7.txt').readAsString();

    var part1 = Day7Logic.part1(Day7Logic.parseInput(input));
    var part2 = Day7Logic.part2(Day7Logic.parseInput(input));

    print('Day 7');
    print("Part 1: $part1");
    print("Part 2: $part2");

    expect(part1, 335271);
    expect(part2, 95851339);
  });

  test("Crab target", () {
    expect(2, Day7Logic.crabTarget1(Day7Logic.parseInput(example)));
    expect(5, Day7Logic.crabTarget2(Day7Logic.parseInput(example)));
  });
}
