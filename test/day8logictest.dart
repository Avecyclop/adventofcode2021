import 'dart:io';

import 'package:adventofcode2021/day8.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var example = """
      be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
      edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
      fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
      fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
      aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
      fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
      dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
      bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
      egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
      gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
      """;

  test("Test Day 8 part 1", () {
    var entries = Day8Logic.parseInput(example);
    var result = Day8Logic.part1(entries);
    expect(result, 26);
  });

  test("Day 8 solve line", () {
    var example = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf";
    var entries = Day8Logic.parseInput(example);
    var result = Day8Logic.solveLine(entries.first);
    expect(result, 5353);
  });

  test("Day 8 calculate output by digits", () {
    expect(Day8Logic.splitSortJoin("ba"), "ab");
    expect(Day8Logic.splitSortJoin("efdc"), "cdef");
    expect(Day8Logic.splitSortJoin("fdce"), "cdef");
  });

  test("Day 8 calculate output by digits", () {
    var example = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf";
    var entries = Day8Logic.parseInput(example);
    var digits = {
      "abcdefg": 8,
      "bcdef": 5,
      "acdfg": 2,
      "abcdf": 3,
      "abd": 7,
      "abcdef": 9,
      "bcdefg": 6,
      "abef": 4,
      "abcdeg": 0,
      "ab": 1,
    };
    var result = Day8Logic.output(entries.first, digits);
    expect(result, 5353);
  });

  test("Test Day 8 part 2", () {
    var entries = Day8Logic.parseInput(example);
    var result = Day8Logic.part2(entries);
    expect(result, 61229);
  });

  test("Day 8 actual puzzle input", () async {
    var input = await File('assets/Day8.txt').readAsString();

    var part1 = Day8Logic.part1(Day8Logic.parseInput(input));
    var part2 = Day8Logic.part2(Day8Logic.parseInput(input));

    print('Day 8');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
