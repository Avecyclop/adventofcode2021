import 'dart:io';

import 'package:adventofcode2021/day13.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0
      
      fold along y=7
      fold along x=5
      """;

  test("Test Day 13 part 1", () {
    var lines = Day13Logic.parseInput(example);
    var result = Day13Logic.part1(lines);
    expect(result, 17);
  });

  test("Test Day 13 part 2", () {
    var lines = Day13Logic.parseInput(example);
    var result = Day13Logic.part2(lines);
    expect(
        result,
        """
        #####
        #...#
        #...#
        #...#
        #####
        """
            .trim()
            .split('\n')
            .map((e) => e.trim())
            .join('\n'));
  });

  test("Day 13 actual puzzle input", () async {
    var input = await File('assets/day13.txt').readAsString();

    var part1 = Day13Logic.part1(Day13Logic.parseInput(input));
    var part2 = Day13Logic.part2(Day13Logic.parseInput(input));

    print('Day 13');
    print("Part 1: $part1");
    print("Part 2: \n$part2");
  });
}
