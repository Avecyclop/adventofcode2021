import 'dart:math';

import 'package:tuple/tuple.dart';

class Day13Logic {
  static Tuple2<Set<Tuple2<int, int>>, List<Tuple2<String, int>>> parseInput(String input) {
    var dots = <Tuple2<int, int>>{};
    var folds = <Tuple2<String, int>>[];
    input.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).forEach((line) {
      if (line.startsWith("fold")) {
        var fold = line.split('=');
        folds.add(Tuple2(fold.first, int.parse(fold.last)));
      } else {
        var dot = line.split(',');
        dots.add(Tuple2(int.parse(dot.first), int.parse(dot.last)));
      }
    });
    return Tuple2(dots, folds);
  }

  static part1(Tuple2<Set<Tuple2<int, int>>, List<Tuple2<String, int>>> dotsAndFolds) {
    var dots = dotsAndFolds.item1;
    var folds = dotsAndFolds.item2;

    var fold = folds.first;
    foldPaper(fold, dots);

    return dots.length;
  }

  static foldPaper(Tuple2<String, int> fold, Set<Tuple2<int, int>> dots) {
    var foldLine = fold.item2;
    if (fold.item1 == "fold along x") {
      var newDots = dots.where((dot) => dot.item1 > foldLine).map((dot) => dot.withItem1(foldLine * 2 - dot.item1)).toList();
      dots.removeWhere((dot) => dot.item1 >= foldLine);
      dots.addAll(newDots);
    } else {
      var newDots = dots.where((dot) => dot.item2 > foldLine).map((dot) => dot.withItem2(foldLine * 2 - dot.item2)).toList();
      dots.removeWhere((dot) => dot.item2 >= foldLine);
      dots.addAll(newDots);
    }
  }

  static part2(Tuple2<Set<Tuple2<int, int>>, List<Tuple2<String, int>>> dotsAndFolds) {
    var dots = dotsAndFolds.item1;
    var folds = dotsAndFolds.item2;

    for (var fold in folds) {
      foldPaper(fold, dots);
    }
    return printableDots(dots);
  }

  static printableDots(Set<Tuple2<int, int>> dots) {
    var maxX = dots.map((e) => e.item1).reduce((value, element) => max(value, element));
    var maxY = dots.map((e) => e.item2).reduce((value, element) => max(value, element));
    return List.generate(maxY + 1, (y) => List.generate(maxX + 1, (x) => dots.contains(Tuple2(x, y)) ? "#" : ".").join()).join('\n');
  }
}
