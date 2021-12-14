import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'day.dart';

class Day12 extends Day {
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

//Future<Map<String, List<Cave>>> _loadDayInput() async => await rootBundle.loadString('assets/day12.txt').then(Day12Logic.parseInput);

class Cave {
  String name;
  bool isSmall;

  Cave(this.name) {
    isSmall = name.toLowerCase() == name;
  }
}

class Day12Logic {
  static Map<String, List<Cave>> parseInput(String input) {
    var caves = <String, List<Cave>>{};
    input.split("\n").map((e) => e.trim()).where((e) => e.isNotEmpty).forEach((line) {
      var cave = line.split("-");
      var cave1 = new Cave(cave.first);
      var cave2 = new Cave(cave.last);
      caves.update(cave.first, (value) => value..add(cave2), ifAbsent: () => [cave2]);
      caves.update(cave.last, (value) => value..add(cave1), ifAbsent: () => [cave1]);
    });
    return caves;
  }

  static part1(Map<String, List<Cave>> caves) {
    traversePart1(List<String> path, Cave newCave, Map<String, List<Cave>> caves) {
      if (newCave.name == "end") return 1;
      if (path.contains(newCave.name) && newCave.isSmall) return 0;

      var newPath = path.toList()..add(newCave.name);
      return caves[newCave.name].map((e) => traversePart1(newPath, e, caves)).reduce((value, element) => value + element);
    }

    return traversePart1(<String>[], new Cave("start"), caves);
  }

  static part2(Map<String, List<Cave>> caves) {
    traversePart2(List<String> path, Cave newCave, Map<String, List<Cave>> caves) {
      if (newCave.name == "end") return 1;
      if (newCave.name == "start" && path.contains("start")) return 0;
      var newPath = path.toList()..add(newCave.name);
      if (newCave.isSmall) {
        var visits = <String, int>{};
        newPath.forEach((e) => visits.update(e, (value) => value + 1, ifAbsent: () => 1));
        var smallVisits = visits.entries.where((e) => e.key.toLowerCase() == e.key).where((e) => e.value > 1).length;
        if (smallVisits > 1) return 0;
        var doubleSmallVisits = visits.entries.where((e) => e.key.toLowerCase() == e.key).where((e) => e.value > 2).length;
        if (doubleSmallVisits > 0) return 0;
      }
      return caves[newCave.name].map((e) => traversePart2(newPath, e, caves)).reduce((value, element) => value + element);
    }

    return traversePart2(<String>[], new Cave("start"), caves);
  }
}
