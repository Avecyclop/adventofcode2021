import 'dart:io';

import 'package:adventofcode2021/day14.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      NNCB
      
      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
      """;

  test("Test Day 14 part 1", () {
    var lines = Day14Logic.parseInput(example);
    var result = Day14Logic.part1(lines);
    expect(result, 1588);
  });

  test("Test Day 14 part 2", () {
    var lines = Day14Logic.parseInput2(example);
    var result = Day14Logic.part2(lines);
    expect(result, 2188189693529);
  });

  test("Day 14 actual puzzle input", () async {
    var input = await File('assets/day14.txt').readAsString();

    var part1 = Day14Logic.part1(Day14Logic.parseInput(input));
    var part2 = Day14Logic.part2(Day14Logic.parseInput2(input));

    print('Day 14');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
