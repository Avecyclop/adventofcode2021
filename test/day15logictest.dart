import 'dart:io';

import 'package:adventofcode2021/day15.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      1163751742
      1381373672
      2136511328
      3694931569
      7463417111
      1319128137
      1359912421
      3125421639
      1293138521
      2311944581
      """;

  test("Test Day 15 part 1", () {
    var lines = Day15Logic.parseInput(example);
    var result = Day15Logic.part1(lines);
    expect(result, 40);
  });

  test("Test Day 15 part 2", () {
    var lines = Day15Logic.parseInput(example);
    var result = Day15Logic.part2(lines);
    expect(result, 315);
  });

  test("Day 15 actual puzzle input", () async {
    var input = await File('assets/day15.txt').readAsString();

    var part1 = Day15Logic.part1(Day15Logic.parseInput(input));
    var part2 = Day15Logic.part2(Day15Logic.parseInput(input));

    expect(part1, 589);
    expect(part2, isNot(3067));
    expect(part2, isNot(2889));
    expect(part2, 2885);

    print('Day 15');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
