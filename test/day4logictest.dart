import 'dart:io';

import 'package:adventofcode2021/day4.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

      22 13 17 11  0
       8  2 23  4 24
      21  9 14 16  7
       6 10  3 18  5
       1 12 20 15 19
      
       3 15  0  2 22
       9 18 13 17  5
      19  8  7 25 23
      20 11 10 24  4
      14 21 16 12  6
      
      14 21 17 24  4
      10 16 15  9 19
      18  8 23 26 20
      22 11 13  6  5
       2  0 12  3  7
    """;

  test("Test day 4 part 1", () {
    var bingo = Day4Logic.parseInput(example);
    var result = bingo.playPart1();
    expect(result, 4512);
  });

  test("Test day 4 part 2 - first solution", () {
    var bingo = Day4Logic.parseInput(example);
    var result = bingo.playPart2();
    expect(result, 1924);
  });

  test("Day 4 actual puzzle input", () async {
    var input = await File('assets/day4.txt').readAsString();

    var part1 = Day4Logic.parseInput(input).playPart1();
    var part2 = Day4Logic.parseInput(input).playPart2();

    print('Day 4');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
