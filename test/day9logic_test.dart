import 'dart:io';

import 'package:adventofcode2021/day9.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
      """;

  test("Test Day 9 part 1", () {
    var lines = Day9Logic.parseInput(example);
    var result = Day9Logic.part1(lines);
    expect(result, 15);
  });

  test("Test Day 9 part 2", () {
    var lines = Day9Logic.parseInput(example);
    var result = Day9Logic.part2(lines);
    expect(result, 1134);
  });

  test("Day 9 actual puzzle input", () async {
    var input = await File('assets/day9.txt').readAsString();

    var part1 = Day9Logic.part1(Day9Logic.parseInput(input));
    var part2 = Day9Logic.part2(Day9Logic.parseInput(input));

    print('Day 9');
    print("Part 1: $part1");
    print("Part 2: $part2");

    expect(part1, 496);
    expect(part2, 902880);
  });
}
