import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'day.dart';

class Day11 extends Day {
  @override
  Widget part1() => _Part1();

  @override
  Widget part2() => _Part2();
}

class _Part1 extends StatefulWidget {
  @override
  _Part1State createState() => _Part1State();
}

class _Part1State extends State<_Part1> {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Part2 extends StatefulWidget {
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<_Part2> {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<List<List<int>>> _loadDayInput() async => await rootBundle.loadString('assets/Day11.txt').then(Day11Logic.parseInput);

class Day11Logic {
  static List<List<int>> parseInput(String input) =>
      input.split("\n").map((e) => e.trim()).where((e) => e.isNotEmpty).map((e) => e.split('').map((e) => int.parse(e)).toList()).toList();

  static part1(List<List<int>> octopuses) {
    addOuterLayer(octopuses);
    int flashes = 0;
    for (int i = 0; i < 100; i++) {
      for (int y = 1; y < 11; y++) {
        for (int x = 1; x < 11; x++) {
          octopuses[y][x]++;
        }
      }
      for (int y = 1; y < 11; y++) {
        for (int x = 1; x < 11; x++) {
          if (octopuses[y][x] > 9) {
            flashes += illuminate(octopuses, x, y);
          }
        }
      }
    }
    return flashes;
  }

  static illuminate(List<List<int>> octopuses, int x, int y) {
    if (octopuses[y][x] <= 0) {
      return 0;
    }
    octopuses[y][x]++;
    if (octopuses[y][x] > 9) {
      octopuses[y][x] = 0;
      return 1 +
          illuminate(octopuses, x - 1, y - 1) +
          illuminate(octopuses, x - 0, y - 1) +
          illuminate(octopuses, x + 1, y - 1) +
          illuminate(octopuses, x - 1, y) +
          illuminate(octopuses, x + 1, y) +
          illuminate(octopuses, x - 1, y + 1) +
          illuminate(octopuses, x - 0, y + 1) +
          illuminate(octopuses, x + 1, y + 1);
    }
    return 0;
  }

  static part2(List<List<int>> octopuses) {
    addOuterLayer(octopuses);
    for (int i = 0; i < 1000000; i++) {
      for (int y = 1; y < 11; y++) {
        for (int x = 1; x < 11; x++) {
          octopuses[y][x]++;
        }
      }
      for (int y = 1; y < 11; y++) {
        for (int x = 1; x < 11; x++) {
          if (octopuses[y][x] > 9) {
            illuminate(octopuses, x, y);
          }
        }
      }
      if (octopuses
              .sublist(1, 11)
              .map((e) => e.sublist(1, 11).reduce((value, element) => value + element))
              .reduce((value, element) => element + value) ==
          0) {
        return i + 1;
      }
    }
    return 0;
  }

  static addOuterLayer(List<List<int>> octopuses) {
    int intMin = -pow(2, 63);
    octopuses.forEach((e) => e.insert(0, intMin));
    octopuses.forEach((e) => e.add(intMin));
    octopuses.insert(0, List.generate(octopuses[0].length, (i) => intMin));
    octopuses.add(List.generate(octopuses[0].length, (i) => intMin));
  }
}
