import 'package:tuple/tuple.dart';

class Day10Logic {
  static List<String> parseInput(String input) => input.split("\n").map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

  static part1(List<String> lines) {
    return lines.map((e) => checkSyntax(e)).map((e) => e.item1).map((e) {
      switch (e) {
        case ")":
          return 3;
        case "]":
          return 57;
        case "}":
          return 1197;
        case ">":
          return 25137;
        default:
          return 0;
      }
    }).reduce((value, element) => value + element);
  }

  static Tuple2<String, List<String>> checkSyntax(String line) {
    var stack = <String>[];
    for (var char in line.split('')) {
      switch (char) {
        case "(":
        case "[":
        case "{":
        case "<":
          stack.insert(0, char);
          break;
        case ")":
          if (stack.removeAt(0) != "(") return Tuple2(char, List.empty());
          break;
        case "]":
          if (stack.removeAt(0) != "[") return Tuple2(char, List.empty());
          break;
        case "}":
          if (stack.removeAt(0) != "{") return Tuple2(char, List.empty());
          break;
        case ">":
          if (stack.removeAt(0) != "<") return Tuple2(char, List.empty());
          break;
        default:
          throw Exception("Unknown character ${char}");
      }
    }
    return Tuple2("", stack.toList());
  }

  static part2(List<String> lines) {
    var map = lines.map((e) => checkSyntax(e)).map((e) => e.item2).where((e) => e.isNotEmpty).map((e) => autoComplete(e)).toList();
    map.sort();
    return map.skip(map.length ~/ 2).first;
  }

  static autoComplete(List<String> stack) => stack.map((e) {
        switch (e) {
          case "(":
            return 1;
          case "[":
            return 2;
          case "{":
            return 3;
          case "<":
            return 4;
          default:
            throw Exception("Unknown character ${e}");
        }
      }).reduce((value, element) => value * 5 + element);
}
