import 'package:tuple/tuple.dart';

class Day7Logic {
  static List<int> parseInput(String input) => input.split("\n").first.trim().split(",").map((e) => int.parse(e)).toList();

  static int maxCrab(List<int> crabs) => crabs.reduce((value, element) => value > element ? value : element);

  static part1(List<int> crabs) {
    return List.generate(maxCrab(crabs), (i) => i)
        .map((i) => crabs.map((pos) => pos - i).map((dist) => dist.abs()).reduce((value, element) => value + element))
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
