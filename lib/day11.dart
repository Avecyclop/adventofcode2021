import 'dart:async';

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
    var maxX = octopuses[0].length - 1;
    var maxY = octopuses.length - 1;
    var flashes = 0;
    for (int step = 1; step <= 100; step++) {
      for (int y = 1; y < maxY; y++) {
        for (int x = 1; x < maxX; x++) {
          octopuses[y][x]++;
        }
      }
      for (int y = 1; y < maxY; y++) {
        for (int x = 1; x < maxX; x++) {
          if (octopuses[y][x] > 9) {
            flashes += illuminate(octopuses, x, y);
          }
        }
      }
    }
    return flashes;
  }

  static illuminate(List<List<int>> octopuses, int x, int y) {
    if (octopuses[y][x] == 0) {
      return 0;
    }
    octopuses[y][x]++;
    if (octopuses[y][x] > 9) {
      octopuses[y][x] = 0;
      return 1 +
          illuminate(octopuses, x - 1, y - 1) +
          illuminate(octopuses, x - 0, y - 1) +
          illuminate(octopuses, x + 1, y - 1) +
          illuminate(octopuses, x - 1, y - 0) +
          illuminate(octopuses, x + 1, y + 0) +
          illuminate(octopuses, x - 1, y + 1) +
          illuminate(octopuses, x + 0, y + 1) +
          illuminate(octopuses, x + 1, y + 1);
    }
    return 0;
  }

  static part2(List<List<int>> octopuses) {
    addOuterLayer(octopuses);
    var maxX = octopuses[0].length - 1;
    var maxY = octopuses.length - 1;
    for (int step = 1; step <= 1000; step++) {
      for (int y = 1; y < maxY; y++) {
        for (int x = 1; x < maxX; x++) {
          octopuses[y][x]++;
        }
      }
      for (int y = 1; y < maxY; y++) {
        for (int x = 1; x < maxX; x++) {
          if (octopuses[y][x] > 9) {
            illuminate(octopuses, x, y);
          }
        }
      }
      if (octopuses
              .sublist(1, maxY)
              .map((e) => e.sublist(1, maxX).reduce((value, element) => value + element))
              .reduce((value, element) => element + value) ==
          0) {
        return step;
      }
    }
    return 0;
  }

  static addOuterLayer(List<List<int>> octopuses) {
    octopuses.forEach((e) => e.insert(0, 0));
    octopuses.forEach((e) => e.add(0));
    octopuses.insert(0, List.generate(octopuses[0].length, (i) => 0));
    octopuses.add(List.generate(octopuses[0].length, (i) => 0));
  }
}
