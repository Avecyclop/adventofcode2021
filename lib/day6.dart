import 'dart:async';

import 'package:animated_background/animated_background.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'day.dart';

class Day6 extends Day {
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
  List<FishAtDay> _series;

  @override
  void initState() {
    super.initState();
    _loadDayInput().then((value) {
      _series = Day6Logic.series(value, 80);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_series == null) {
      return getBackgroundWithStack(CircularProgressIndicator(), this);
    }
    return getBackgroundWithStack(getChart(_series), this);
  }
}

class _Part2 extends StatefulWidget {
  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<_Part2> with TickerProviderStateMixin {
  List<FishAtDay> _series;

  @override
  void initState() {
    super.initState();
    _loadDayInput().then((value) {
      _series = Day6Logic.series(value, 256);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_series == null) {
      return getBackgroundWithStack(CircularProgressIndicator(), this);
    }
    return getBackgroundWithStack(getChart(_series), this);
  }
}

Widget getBackgroundWithStack(Widget widget, TickerProvider ticker) {
  return AnimatedBackground(
    behaviour: BubblesBehaviour(),
    vsync: ticker,
    child: Stack(children: [widget, getFish()], alignment: AlignmentDirectional.center),
  );
}

Widget getChart(List<FishAtDay> data) {
  var series = [
    Series<FishAtDay, num>(
      id: "fish",
      data: data,
      domainFn: (FishAtDay fishAtDay, _) => fishAtDay.day,
      measureFn: (FishAtDay fishAtDay, _) => fishAtDay.fish,
    )
  ];
  return LineChart(series,
      primaryMeasureAxis: NumericAxisSpec(
        renderSpec: GridlineRendererSpec(
          lineStyle: LineStyleSpec(thickness: 1, color: Color.black),
        ),
      ));
}

Widget getFish() {
  return Icon(TablerIcons.fish, size: 100, color: Colors.orange);
}

class FishAtDay {
  int day;
  int fish;

  FishAtDay(this.day, this.fish);
}

Future<List<int>> _loadDayInput() async => await rootBundle.loadString('assets/day6.txt').then(Day6Logic.parseInput);

class Day6Logic {
  static List<int> parseInput(String input) => input.split("\n").first.trim().split(",").map((e) => int.parse(e)).toList();

  static part1(List<int> individualFish) {
    var fishAtDay = <int>[];
    for (int i = 0; i < 9; i++) {
      fishAtDay.add(individualFish.where((f) => f == i).length);
    }
    for (int i = 0; i < 80; i++) {
      var birthingFish = fishAtDay.removeAt(0);
      fishAtDay[6] += birthingFish;
      fishAtDay.add(birthingFish);
    }
    return fishAtDay.reduce((value, element) => value + element);
  }

  static part2(List<int> individualFish) {
    var fishAtDay = <int>[];
    for (int i = 0; i < 9; i++) {
      fishAtDay.add(individualFish.where((f) => f == i).length);
    }
    for (int i = 0; i < 256; i++) {
      var birthingFish = fishAtDay.removeAt(0);
      fishAtDay[6] += birthingFish;
      fishAtDay.add(birthingFish);
    }
    return fishAtDay.reduce((value, element) => value + element);
  }

  static List<FishAtDay> series(List<int> individualFish, int days) {
    List<FishAtDay> series = <FishAtDay>[];
    var fishAtDay = <int>[];
    for (int i = 0; i < 9; i++) {
      fishAtDay.add(individualFish.where((f) => f == i).length);
    }
    for (int i = 0; i < days; i++) {
      var birthingFish = fishAtDay.removeAt(0);
      fishAtDay[6] += birthingFish;
      fishAtDay.add(birthingFish);
      var sum = fishAtDay.reduce((value, element) => value + element);
      series.add(FishAtDay(i, sum));
    }
    return series;
  }
}
