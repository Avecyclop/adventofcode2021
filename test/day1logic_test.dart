import 'dart:io';

import 'package:adventofcode2021/day1.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test day 1 part 1", () {
    var test = """
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263""";
    var input = Day1Logic.parseInput(test);
    var result = Day1Logic.part1(input);
    expect(result, 7);
  });

  test("Test day 1 part 2", () {
    var test = """
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263""";
    var input = Day1Logic.parseInput(test);
    var result = Day1Logic.part2(input);
    expect(result, 5);
  });

  test("Day 1 actual puzzle input", () async {
    var input = await File('assets/day1.txt').readAsString();
    var numbers = Day1Logic.parseInput(input);

    var part1 = Day1Logic.part1(numbers);
    var part2 = Day1Logic.part2(numbers);

    print('Day 1');
    print("Part 1: $part1");
    print("Part 2: $part2");

    expect(part1, 1451);
    expect(part2, 1395);
  });
}
