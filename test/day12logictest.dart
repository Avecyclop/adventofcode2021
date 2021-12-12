import 'dart:io';

import 'package:adventofcode2021/day12.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example1 = """
      start-A
      start-b
      A-c
      A-b
      b-d
      A-end
      b-end
      """;

  var example2 = """
      dc-end
      HN-start
      start-kj
      dc-start
      dc-HN
      LN-dc
      HN-end
      kj-sa
      kj-HN
      kj-dc
      """;

  var example3 = """
      fs-end
      he-DX
      fs-he
      start-DX
      pj-DX
      end-zg
      zg-sl
      zg-pj
      pj-he
      RW-he
      fs-DX
      pj-RW
      zg-RW
      start-pj
      he-WI
      zg-he
      pj-fs
      start-RW
      """;

  test("Test Day 12 part 1 - example 1", () {
    var lines = Day12Logic.parseInput(example1);
    var result = Day12Logic.part1(lines);
    expect(result, 10);
  });

  test("Test Day 12 part 1 - example 2", () {
    var lines = Day12Logic.parseInput(example2);
    var result = Day12Logic.part1(lines);
    expect(result, 19);
  });

  test("Test Day 12 part 1 - example 3", () {
    var lines = Day12Logic.parseInput(example3);
    var result = Day12Logic.part1(lines);
    expect(result, 226);
  });

  test("Test Day 12 part 2 - example 1", () {
    var lines = Day12Logic.parseInput(example1);
    var result = Day12Logic.part2(lines);
    expect(result, 36);
  });

  test("Test Day 12 part 2 - example 2", () {
    var lines = Day12Logic.parseInput(example2);
    var result = Day12Logic.part2(lines);
    expect(result, 103);
  });

  test("Test Day 12 part 2 - example 3", () {
    var lines = Day12Logic.parseInput(example3);
    var result = Day12Logic.part2(lines);
    expect(result, 3509);
  });

  test("Day 12 actual puzzle input", () async {
    var input = await File('assets/day12.txt').readAsString();

    var part1 = Day12Logic.part1(Day12Logic.parseInput(input));
    var part2 = Day12Logic.part2(Day12Logic.parseInput(input));

    print('Day 12');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
