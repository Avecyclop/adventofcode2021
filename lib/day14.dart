import 'dart:math';

import 'package:characters/src/extensions.dart';
import 'package:tuple/tuple.dart';

class Day14Logic {
  static Tuple2<String, Map<String, String>> parseInput(String input) {
    var lines = input.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty);
    var template = lines.first;
    var pairsInsertions = <String, String>{};
    lines.skip(1).forEach((e) {
      var split = e.split(" -> ");
      var pair = split.first;
      var insertion = split.last + pair[1];
      pairsInsertions.putIfAbsent(pair, () => insertion);
    });
    return Tuple2(template, pairsInsertions);
  }

  static part1(Tuple2<String, Map<String, String>> data) {
    var polymer = data.item1;
    var insertions = data.item2;

    for (int step = 0; step < 10; step++) {
      score(polymer);
      var newPolymer = polymer[0];
      for (int i = 0; i < polymer.length - 1; i++) {
        var pair = polymer.substring(i, i + 2);
        var newSegment = insertions[pair];
        newPolymer = "$newPolymer${newSegment}";
      }
      polymer = newPolymer;
    }

    return score(polymer);
  }

  static int score(String polymer) {
    var counter = <String, int>{};
    polymer.characters.forEach((e) => counter.update(e, (value) => value + 1, ifAbsent: () => 1));
    var mostElement = counter.values.reduce((value, element) => max(value, element));
    var leastElement = counter.values.reduce((value, element) => min(value, element));

    /*
    var mostCommonElement = counter.entries.firstWhere((e) => e.value == mostElement).key;
    var leastCommonElement = counter.entries.firstWhere((e) => e.value == leastElement).key;
    print("${counter.toString().padRight(46)} $mostCommonElement - $leastCommonElement = ${mostElement - leastElement}");
    */
    //print("${polymer.padRight(50)} ${counter.toString().padRight(45)} ${mostElement - leastElement}");

    return mostElement - leastElement;
  }

  static Tuple2<String, Map<String, Tuple2<String, String>>> parseInput2(String input) {
    var lines = input.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty);
    var template = lines.first;
    var inserts = <String, Tuple2<String, String>>{};
    lines.skip(1).forEach((e) {
      var split = e.split(" -> ");
      var pair = split.first;
      var newPair1 = pair[0] + split.last;
      var newPair2 = split.last + pair[1];
      inserts.putIfAbsent(pair, () => Tuple2(newPair1, newPair2));
    });
    return Tuple2(template, inserts);
  }

  static part2(Tuple2<String, Map<String, Tuple2<String, String>>> data) {
    var template = data.item1;
    var inserts = data.item2;
    var pairs = <String, int>{};
    for (int i = 0; i < template.length - 1; i++) {
      pairs.update(template.substring(i, i + 2), (value) => value + 1, ifAbsent: () => 1);
    }

    for (int step = 0; step < 40; step++) {
      score2(pairs, template);
      var newPairs = <String, int>{};
      pairs.forEach((key, value) {
        var newPair = inserts[key];
        newPairs.update(newPair.item1, (v) => v + value, ifAbsent: () => value);
        newPairs.update(newPair.item2, (v) => v + value, ifAbsent: () => value);
      });
      pairs = newPairs;
    }

    return score2(pairs, template);
  }

  static int score2(Map<String, int> pairs, String template) {
    var counter = <String, int>{};
    pairs.forEach((key, value) {
      counter.update(key[0], (v) => value + v, ifAbsent: () => value);
      counter.update(key[1], (v) => value + v, ifAbsent: () => value);
    });
    counter.update(template[0], (value) => value + 1);
    counter.update(template[template.length - 1], (value) => value + 1);
    counter.updateAll((key, value) => value ~/ 2);
    var mostElement = counter.values.reduce((value, element) => max(value, element));
    var leastElement = counter.values.reduce((value, element) => min(value, element));
    //print("${pairs.toString().padRight(50)} ${counter.toString().padRight(45)} ${mostElement - leastElement}");
    return mostElement - leastElement;
  }
}
