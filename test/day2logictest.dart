import 'dart:io';

import 'package:adventofcode2021/day2.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test day 2 part 1", () {
    var test = """
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    """;
    var input = Day2Logic.parseInput(test);
    var result = Day2Logic.part1(input);
    expect(result, 150);
  });

  test("Test day 2 part 2", () {
    var test = """
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    """;
    var input = Day2Logic.parseInput(test);
    var result = Day2Logic.part2(input);
    expect(result, 900);
  });

  test("Day 2 actual puzzle input", () async {
    var input = await File('assets/day2.txt').readAsString();
    var commands = Day2Logic.parseInput(input);

    var part1 = Day2Logic.part1(commands);
    var part2 = Day2Logic.part2(commands);

    print('Day 2');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
