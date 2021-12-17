import 'dart:io';

import 'package:adventofcode2021/day16.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test Day 16 part 1 - example 1", () {
    var lines = Day16Logic.parseInput("D2FE28");
    var result = Day16Logic.part1(lines);
    expect(result, 6);
  });

  test("Test Day 16 part 1 - example 2", () {
    var lines = Day16Logic.parseInput("8A004A801A8002F478");
    var result = Day16Logic.part1(lines);
    expect(result, 16);
  });

  test("Test Day 16 part 1 - example 3", () {
    var lines = Day16Logic.parseInput("C0015000016115A2E0802F182340");
    var result = Day16Logic.part1(lines);
    expect(result, 23);
  });

  test("Test Day 16 part 1 - example 4", () {
    var lines = Day16Logic.parseInput("A0016C880162017C3686B18A3D4780");
    var result = Day16Logic.part1(lines);
    expect(result, 31);
  });

  test("Test Day 16 part 2 - example 1", () {
    var lines = Day16Logic.parseInput("C200B40A82");
    var result = Day16Logic.part2(lines);
    expect(result, 3);
  });

  test("Test Day 16 part 2 - example 2", () {
    var lines = Day16Logic.parseInput("04005AC33890");
    var result = Day16Logic.part2(lines);
    expect(result, 54);
  });

  test("Test Day 16 part 2 - example 3", () {
    var lines = Day16Logic.parseInput("880086C3E88112");
    var result = Day16Logic.part2(lines);
    expect(result, 7);
  });

  test("Test Day 16 part 2 - example 4", () {
    var lines = Day16Logic.parseInput("CE00C43D881120");
    var result = Day16Logic.part2(lines);
    expect(result, 9);
  });

  test("Test Day 16 part 2 - example 5", () {
    var lines = Day16Logic.parseInput("D8005AC2A8F0");
    var result = Day16Logic.part2(lines);
    expect(result, 1);
  });

  test("Test Day 16 part 2 - example 6", () {
    var lines = Day16Logic.parseInput("F600BC2D8F");
    var result = Day16Logic.part2(lines);
    expect(result, 0);
  });

  test("Test Day 16 part 2 - example 7", () {
    var lines = Day16Logic.parseInput("9C005AC2F8F0");
    var result = Day16Logic.part2(lines);
    expect(result, 0);
  });

  test("Test Day 16 part 2 - example 8", () {
    var lines = Day16Logic.parseInput("9C0141080250320F1802104A08");
    var result = Day16Logic.part2(lines);
    expect(result, 1);
  });

  test("Day 16 actual puzzle input", () async {
    var input = await File('assets/day16.txt').readAsString();

    var part1 = Day16Logic.part1(Day16Logic.parseInput(input));
    var part2 = Day16Logic.part2(Day16Logic.parseInput(input));

    expect(part1, isNot(963));
    expect(part1, 906);
    expect(part2, isNot(819324477235));
    expect(part2, 819324480368);

    print('Day 16');
    print("Part 1: $part1");
    print("Part 2: $part2");
  });
}
