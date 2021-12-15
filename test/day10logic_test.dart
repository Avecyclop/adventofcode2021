import 'dart:io';

import 'package:adventofcode2021/day10.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
      """;

  test("Test Day 10 part 1", () {
    var lines = Day10Logic.parseInput(example);
    var result = Day10Logic.part1(lines);
    expect(result, 26397);
  });

  test("Test Day 10 part 2", () {
    var lines = Day10Logic.parseInput(example);
    var result = Day10Logic.part2(lines);
    expect(result, 288957);
  });

  test("Day 10 actual puzzle input", () async {
    var input = await File('assets/Day10.txt').readAsString();

    var part1 = Day10Logic.part1(Day10Logic.parseInput(input));
    var part2 = Day10Logic.part2(Day10Logic.parseInput(input));

    print('Day 10');
    print("Part 1: $part1");
    print("Part 2: $part2");

    expect(part1, 339411);
    expect(part2, 2289754624);
  });
}
