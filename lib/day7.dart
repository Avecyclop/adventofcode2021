import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

import 'day.dart';

class Day7 extends Day {
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

Future<List<int>> _loadDayInput() async => await rootBundle.loadString('assets/day7.txt').then(Day7Logic.parseInput);

class Day7Logic {
  static List<int> parseInput(String input) => input.split("\n").first.trim().split(",").map((e) => int.parse(e)).toList();

  static int maxCrab(List<int> crabs) => crabs.reduce((value, element) => value > element ? value : element);

  static part1(List<int> crabs) {
    return List.generate(maxCrab(crabs), (i) => i)
        .map((i) => crabs
            .map((pos) => pos - i)
            .map((dist) => dist.abs())
            .reduce((value, element) => value + element))
        .reduce((value, element) => value < element ? value : element);
  }

  static part2(List<int> crabs) {
    return List.generate(maxCrab(crabs), (i) => i)
        .map((i) => crabs
            .map((pos) => pos - i)
            .map((dist) => dist.abs())
            .map((n) => (n * (n + 1)) ~/ 2)
            .reduce((value, element) => value + element))
        .reduce((value, element) => value < element ? value : element);
  }

  static crabTarget1(List<int> crabs) {
    return List.generate(maxCrab(crabs), (i) => i)
        .map((i) => Tuple2(i, crabs.map((pos) => pos - i).map((dist) => dist.abs()).reduce((value, element) => value + element)))
        .reduce((value, element) => value.item2 < element.item2 ? value : element)
        .item1;
  }

  static crabTarget2(List<int> crabs) {
    return List.generate(maxCrab(crabs), (i) => i)
        .map((i) => Tuple2(
            i,
            crabs
                .map((pos) => pos - i)
                .map((dist) => dist.abs())
                .map((n) => (n * (n + 1)) ~/ 2)
                .reduce((value, element) => value + element)))
        .reduce((value, element) => value.item2 < element.item2 ? value : element)
        .item1;
  }
}
