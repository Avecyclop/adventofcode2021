import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'day.dart';

class Day9 extends Day {
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
  var _heightMap;

  @override
  void initState() {
    super.initState();
    _loadDayInput().then((value) {
      _heightMap = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_heightMap == null) {
      return CircularProgressIndicator();
    }
    return CustomPaint(painter: HeightMapPainter(_heightMap));
  }
}

class HeightMapPainter extends CustomPainter {
  List<List<int>> _heightMap;

  HeightMapPainter(this._heightMap);

  @override
  void paint(Canvas canvas, Size size) {
    var height = size.height / _heightMap.length;
    var width = size.width / _heightMap[0].length;
    for (int y = 0; y < _heightMap.length; y++) {
      for (int x = 0; x < _heightMap[y].length; x++) {
        var point = _heightMap[y][x];
        var colorTint = point == 9 ? 50 : (9 - point) * 100;
        canvas.drawRect(Rect.fromLTWH(x * width, y * height, width, height), Paint()..color = Colors.blueGrey[colorTint]);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class _Part2 extends StatefulWidget {
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<_Part2> {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<List<List<int>>> _loadDayInput() async => await rootBundle.loadString('assets/day9.txt').then(Day9Logic.parseInput);

class Day9Logic {
  static List<List<int>> parseInput(String input) {
    return input
        .split("\n")
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .map((e) => e.split('').map((e) => int.parse(e)).toList())
        .toList();
  }

  static part1(List<List<int>> points) {
    addOuterLayer(points);
    var riskSum = 0;
    for (int y = 1; y < points.length - 1; y++) {
      for (int x = 1; x < points[y].length - 1; x++) {
        if (points[y][x] < min(min(points[y - 1][x], points[y + 1][x]), min(points[y][x - 1], points[y][x + 1]))) {
          riskSum += points[y][x] + 1;
        }
      }
    }
    return riskSum;
  }

  static part2(List<List<int>> points) {
    addOuterLayer(points);

    findBasin(List<List<int>> points, int x, int y) {
      if (points[y][x] == 9) {
        return 0;
      } else {
        points[y][x] = 9;
        return 1 + findBasin(points, x - 1, y) + findBasin(points, x + 1, y) + findBasin(points, x, y - 1) + findBasin(points, x, y + 1);
      }
    }

    var basins = <int>[];
    for (int y = 1; y < points.length - 1; y++) {
      for (int x = 1; x < points[y].length - 1; x++) {
        basins.add(findBasin(points, x, y));
      }
    }
    basins.sort((b, a) => a.compareTo(b));
    return basins.sublist(0, 3).reduce((value, element) => value * element);
  }

  static addOuterLayer(List<List<int>> points) {
    points.forEach((e) => e.insert(0, 9));
    points.forEach((e) => e.add(9));
    points.insert(0, List.generate(points[0].length, (i) => 9));
    points.add(List.generate(points[0].length, (i) => 9));
  }
}
