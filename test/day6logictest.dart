import 'dart:io';

import 'package:adventofcode2021/Day6.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      3,4,3,1,2
      """;

  test("Test Day 6 part 1", () {
    var lines = Day6Logic.parseInput(example);
    var result = Day6Logic.part1(lines);
    expect(result, 5934);
  });

  test("Test Day 6 part 2", () {
    var lines = Day6Logic.parseInput(example);
    var result = Day6Logic.part2(lines);
    expect(result, 26984457539);
  });

  test("Day 6 actual puzzle input", () async {
    var input = await File('assets/day6.txt').readAsString();

    var part1 = Day6Logic.part1(Day6Logic.parseInput(input));
    var part2 = Day6Logic.part2(Day6Logic.parseInput(input));

    print('Day 6');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
