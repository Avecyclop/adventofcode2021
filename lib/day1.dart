import 'dart:async';

import 'package:adventofcode2021/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'day.dart';

class Day1 extends Day {
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
  var _timer;
  var _index = 1;

  var _text = "...";
  var _icon = Icon(Icons.adjust, color: Colors.grey);

  @override
  void initState() {
    super.initState();

    _loadDayInput().then((value) {
      _timer = Timer.periodic(Duration(milliseconds: 250), (t) {
        if (_index < value.length) {
          var value1 = value[_index - 1];
          var value2 = value[_index];
          var newText = "$value1 < $value2 ";
          var newIcon =
              value1 < value2 ? Icon(Icons.arrow_circle_up, color: Colors.lightGreen) : Icon(Icons.arrow_circle_down, color: Colors.red);
          setState(() {
            _text = newText;
            _icon = newIcon;
          });
        } else {
          var part1 = Day1Logic.part1(value);
          t.cancel();
          setState(() {
            _text = part1;
            _icon = Icon(Icons.check_box, color: Colors.lightGreen);
          });
        }
        _index++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [WhiteText(_text), _icon]));
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

class _Part2State extends State<_Part2> {
  var _timer;
  var _index = 3;

  var _text = "...";
  var _icon = Icon(Icons.adjust, color: Colors.grey);

  @override
  void initState() {
    super.initState();

    _loadDayInput().then((value) {
      _timer = Timer.periodic(Duration(milliseconds: 250), (t) {
        if (_index < value.length) {
          var sum0 = value[_index - 3] + value[_index - 2] + value[_index - 1];
          var sum1 = value[_index - 2] + value[_index - 1] + value[_index];
          var newText = "$sum0 < $sum1 ";
          var newIcon =
              sum0 < sum1 ? Icon(Icons.arrow_circle_up, color: Colors.lightGreen) : Icon(Icons.arrow_circle_down, color: Colors.red);
          setState(() {
            _text = newText;
            _icon = newIcon;
          });
        } else {
          var part1 = Day1Logic.part1(value);
          t.cancel();
          setState(() {
            _text = part1;
            _icon = Icon(Icons.check_box, color: Colors.lightGreen);
          });
        }
        _index++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [WhiteText(_text), _icon]));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}

Future<List<int>> _loadDayInput() async => await rootBundle.loadString('assets/day1.txt').then(Day1Logic.parseInput);

class Day1Logic {
  static List<int> parseInput(String input) {
    var numbers = <int>[];
    input.split("\n").forEach((element) {
      if (element.isNotEmpty) {
        numbers.add(int.parse(element.trimLeft().trimRight()));
      }
    });
    return numbers;
  }

  static part1(List<int> numbers) {
    var prev = numbers[0];
    var increases = 0;
    for (int i = 1; i < numbers.length; i++) {
      if (numbers[i] > prev) {
        increases++;
      }
      prev = numbers[i];
    }
    return increases;
  }

  static part2(List<int> numbers) {
    var prev0 = numbers[0];
    var prev1 = numbers[1];
    var sums = <int>[];
    for (int i = 2; i < numbers.length; i++) {
      sums.add(prev0 + prev1 + numbers[i]);
      prev0 = prev1;
      prev1 = numbers[i];
    }
    return part1(sums);
  }
}
