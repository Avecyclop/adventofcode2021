import 'dart:async';

import 'package:adventofcode2021/lib.dart';
import 'package:animated_background/animated_background.dart';
import 'package:animated_background/lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:tuple/tuple.dart';

import 'day.dart';

class Day2 extends Day {
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
  var _timer;
  var _i = 0;
  var _x = 0;
  var _y = 0;

  @override
  void initState() {
    super.initState();
    _loadDayInput().then((value) {
      _timer = Timer.periodic(Duration(milliseconds: 250), (t) {
        if (_i >= value.length) {
          t.cancel();
          return;
        }
        var command = value[_i++];
        var newX = _x + (command.item1 == "forward" ? command.item2 : 0);
        var newY = _y +
            (command.item1 == "down"
                ? command.item2
                : command.item1 == "up"
                    ? -command.item2
                    : 0);
        setState(() {
          _x = newX;
          _y = newY;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
        behaviour: RacingLinesBehaviour(
          direction: LineDirection.Rtl,
          numLines: 10,
        ),
        vsync: this,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [WhiteText("($_x, $_y)"), Icon(TablerIcons.submarine, color: Colors.yellow, size: 50)],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}

class _Part2 extends StatefulWidget {
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<_Part2> with TickerProviderStateMixin {
  var _timer;
  var _i = 0;
  var _x = 0;
  var _y = 0;
  var _a = 0;

  @override
  void initState() {
    super.initState();
    _loadDayInput().then((value) {
      _timer = Timer.periodic(Duration(milliseconds: 250), (t) {
        if (_i >= value.length) {
          t.cancel();
          return;
        }
        var command = value[_i++];
        var newX = _x + (command.item1 == "forward" ? command.item2 : 0);
        var newY = _y + (command.item1 == "forward" ? command.item2 : 0) * _a;
        var newA = _a +
            (command.item1 == "down"
                ? command.item2
                : command.item1 == "up"
                    ? -command.item2
                    : 0);
        setState(() {
          _x = newX;
          _y = newY;
          _a = newA;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
        behaviour: RacingLinesBehaviour(
          direction: LineDirection.Rtl,
          numLines: 10,
        ),
        vsync: this,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [WhiteText("($_x, $_y, $_a⌖)"), Icon(TablerIcons.submarine, color: Colors.yellow, size: 50)],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}

Future<List<Tuple2<String, int>>> _loadDayInput() async => await rootBundle.loadString('assets/day2.txt').then(Day2Logic.parseInput);

class Day2Logic {
  static List<Tuple2<String, int>> parseInput(String input) {
    var commands = <Tuple2<String, int>>[];
    input.split("\n").forEach((element) {
      if (element.trim().isNotEmpty) {
        var parts = element.trim().split(" ");
        commands.add(Tuple2(parts.first, int.parse(parts.last)));
      }
    });
    return commands;
  }

  static part1(List<Tuple2<String, int>> commands) {
    // Interesting type inference behavior
    //var fold = commands.fold(Tuple2<int, int>(0, 0), (prev, e) {
    Tuple2<int, int> fold = commands.fold(Tuple2(0, 0), (prev, e) {
      switch (e.item1) {
        case "forward":
          return prev.withItem1(prev.item1 + e.item2);
        case "up":
          return prev.withItem2(prev.item2 - e.item2);
        case "down":
          return prev.withItem2(prev.item2 + e.item2);
        default:
          throw Exception("Unknown command: ${e.item1}");
      }
    });
    return fold.item1 * fold.item2;
  }

  static part2(List<Tuple2<String, int>> commands) {
    Tuple3<int, int, int> fold = commands.fold(Tuple3(0, 0, 0), (prev, e) {
      switch (e.item1) {
        case "forward":
          return prev.withItem1(prev.item1 + e.item2).withItem2(prev.item2 + e.item2 * prev.item3);
        case "up":
          return prev.withItem3(prev.item3 - e.item2);
        case "down":
          return prev.withItem3(prev.item3 + e.item2);
        default:
          throw Exception("Unknown command: ${e.item1}");
      }
    });
    return fold.item1 * fold.item2;
  }
}
