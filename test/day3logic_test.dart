import 'dart:io';

import 'package:adventofcode2021/day3.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test day 3 part 1", () {
    var test = """
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    """;
    var input = Day3Logic.parseInput(test);
    var result = Day3Logic.part1(input);
    expect(result, 198);
  });

  test("Test day 3 part 2", () {
    var test = """
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    """;
    var input = Day3Logic.parseInput(test);
    var result = Day3Logic.part2(input);
    expect(result, 230);
  });

  test("Day 3 actual puzzle input", () async {
    var input = await File('assets/day3.txt').readAsString();
    var commands = Day3Logic.parseInput(input);

    var part1 = Day3Logic.part1(commands);
    var part2 = Day3Logic.part2(commands);

    print('Day 3');
    print("Part 1: $part1");
    print("Part 2: $part2");

    expect(part1, 2003336);
    expect(part2, 1877139);
  });
}
