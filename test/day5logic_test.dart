import 'dart:io';

import 'package:adventofcode2021/day5.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
      """;

  test("Test day 5 part 1", () {
    var lines = Day5Logic.parseInput(example);
    var result = Day5Logic.part1(lines);
    expect(result, 5);
  });

  test("Test day 5 part 2", () {
    var lines = Day5Logic.parseInput(example);
    var result = Day5Logic.part2(lines);
    expect(result, 12);
  });

  test("Day 5 actual puzzle input", () async {
    var input = await File('assets/day5.txt').readAsString();

    var part1 = Day5Logic.part1(Day5Logic.parseInput(input));
    var part2 = Day5Logic.part2(Day5Logic.parseInput(input));

    print('Day 5');
    print("Part 1: $part1");
    print("Part 2: $part2");

    expect(part1, 4728);
    expect(part2, 17717);
  });
}
