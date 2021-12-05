import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

import 'day.dart';

class Day5 extends Day {
  @override
  Widget part1() => _Part1();

  @override
  Widget part2() => _Part2();
}

class _Part1 extends StatefulWidget {
  @override
  _Part1State createState() => _Part1State();
}

class _Part1State extends State<_Part1> with TickerProviderStateMixin {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Part2 extends StatefulWidget {
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<_Part2> with TickerProviderStateMixin {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<dynamic> _loadDayInput() async => await rootBundle.loadString('assets/day5.txt').then(Day5Logic.parseInput);

class Line {
  int x1;
  int y1;
  int x2;
  int y2;

  Line(this.x1, this.y1, this.x2, this.y2);
}

class Day5Logic {
  static List<Line> parseInput(String input) {
    var lines = <Line>[];
    input.split("\n").map((e) => e.trim()).forEach((line) {
      if (line.isNotEmpty) {
        var split = line.split(" -> ");
        var first = split.first.split(",");
        var last = split.last.split(",");
        lines.add(Line(int.parse(first.first), int.parse(first.last), int.parse(last.first), int.parse(last.last)));
      }
    });
    return lines;
  }

  static drawHorizontalAndVertical(List<Line> lines, Map<Tuple2<int, int>, int> map) {
    lines.where((line) => line.y1 == line.y2).forEach((line) {
      var minX = min(line.x1, line.x2);
      var maxX = max(line.x1, line.x2);
      for (int x = minX; x <= maxX; x++) {
        map.update(Tuple2(x, line.y1), (value) => value + 1, ifAbsent: () => 1);
      }
    });
    lines.where((line) => line.x1 == line.x2).forEach((line) {
      var minY = min(line.y1, line.y2);
      var maxY = max(line.y1, line.y2);
      for (int y = minY; y <= maxY; y++) {
        map.update(Tuple2(line.x1, y), (value) => value + 1, ifAbsent: () => 1);
      }
    });
  }

  static drawDiagonal(List<Line> lines, Map<Tuple2<int, int>, int> map) {
    lines.where((line) => line.x1 != line.x2 && line.y1 != line.y2).forEach((line) {
      var minX = min(line.x1, line.x2);
      var maxX = max(line.x1, line.x2);
      var minY = min(line.y1, line.y2);
      var maxY = max(line.y1, line.y2);
      var startY = minX == line.x1 ? (minY == line.y1 ? minY : maxY) : (minY == line.y1 ? maxY : minY);
      var direction = minX == line.x1 ? (minY == line.y1 ? 1 : -1) : (minY == line.y1 ? -1 : 1);
      for (int i = 0; i <= maxX - minX; i++) {
        map.update(Tuple2(minX + i, startY + i * direction), (value) => value + 1, ifAbsent: () => 1);
      }
    });
  }

  static part1(List<Line> lines) {
    var map = Map<Tuple2<int, int>, int>();
    drawHorizontalAndVertical(lines, map);
    return map.values.where((value) => value > 1).length;
  }

  static part2(List<Line> lines) {
    var map = Map<Tuple2<int, int>, int>();
    drawHorizontalAndVertical(lines, map);
    drawDiagonal(lines, map);
    return map.values.where((value) => value > 1).length;
  }
}
