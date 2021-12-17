import 'dart:io';

import 'package:adventofcode2021/day17.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = 'target area: x=20..30, y=-10..-5';

  test("Test Day 17 part 1", () {
    var lines = Day17Logic.parseInput(example);
    var result = Day17Logic.part1(lines);
    expect(result, 45);
  });

  test("Test Day 17 part 2", () {
    var lines = Day17Logic.parseInput(example);
    var result = Day17Logic.part2(lines);
    expect(result, 112);
  });

  test("Day 17 actual puzzle input", () async {
    var input = await File('assets/day17.txt').readAsString();

    var part1 = Day17Logic.part1(Day17Logic.parseInput(input));
    var part2 = Day17Logic.part2(Day17Logic.parseInput(input));

    expect(part1, 8911);
    expect(part2, 4748);

    print('Day 17');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
