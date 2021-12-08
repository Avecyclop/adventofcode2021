import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'day.dart';

class Day8 extends Day {
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

Future<List<Entry>> _loadDayInput() async => await rootBundle.loadString('assets/day8.txt').then(Day8Logic.parseInput);

class Entry {
  List<String> signals;
  List<String> output;

  Entry(this.signals, this.output);
}

class Day8Logic {
  static List<Entry> parseInput(String input) {
    return input.split("\n").map((e) => e.trim()).where((e) => e.isNotEmpty).map((e) {
      var parts = e.split(" | ");
      var signals = parts.first.split(" ").map((e) => splitSortJoin(e)).toList();
      var output = parts.last.split(" ").map((e) => splitSortJoin(e)).toList();
      return Entry(signals, output);
    }).toList();
  }

  static String splitSortJoin(String e) {
    var line = e.split('');
    line.sort();
    return line.join();
  }

  static part1(List<Entry> entries) {
    return entries.expand((e) => e.output).map((e) => e.length).where((e) => e == 2 || e == 3 || e == 4 || e == 7).length;
  }

  static solveLine(Entry entry) {
    var digits = Map<String, int>();
    var signals = entry.signals.toList();
    // Find 1, 4, 5, 8: Unique number of segments used
    var one = signals.singleWhere((e) => e.length == 2);
    var four = signals.singleWhere((e) => e.length == 4);
    var seven = signals.singleWhere((e) => e.length == 3);
    var eight = signals.singleWhere((e) => e.length == 7);
    digits[one] = 1;
    digits[four] = 4;
    digits[seven] = 7;
    digits[eight] = 8;
    signals.remove(one);
    signals.remove(four);
    signals.remove(seven);
    signals.remove(eight);
    // Find 6: Uses six segments but shares only one segment with 1's two segments
    var six = signals.where((e) => e.length == 6).singleWhere((e) => e.contains(one[0]) ^ e.contains(one[1]));
    digits[six] = 6;
    signals.remove(six);
    // Find 9: Uses six segments and shares four with 4
    var nine = signals.where((e) => e.length == 6).singleWhere((e) => commonSegments(e, four) == 4);
    digits[nine] = 9;
    signals.remove(nine);
    // Find 0: Last digit that uses six segments
    var zero = signals.singleWhere((e) => e.length == 6);
    digits[zero] = 0;
    signals.remove(zero);
    // Find 3: Shares three segments with 7
    var three = signals.singleWhere((e) => commonSegments(e, seven) == 3);
    digits[three] = 3;
    signals.remove(three);
    // Find 5: Shares all its five segments with 6
    var five = signals.singleWhere((e) => commonSegments(e, six) == 5);
    digits[five] = 5;
    signals.remove(five);
    // Find 2: Last digit left is 2
    digits[signals.single] = 2;

    return output(entry, digits);
  }

  static commonSegments(String signal1, String signal2) {
    return signal1.split('').where((e) => signal2.contains(e)).length;
  }

  static output(Entry entry, Map<String, int> digits) {
    return entry.output.map((e) => digits[e]).reduce((value, element) => value * 10 + element);
  }

  static part2(List<Entry> entries) {
    return entries.map((e) => solveLine(e)).reduce((value, element) => value + element);
  }
}
