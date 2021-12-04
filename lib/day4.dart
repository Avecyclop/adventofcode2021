import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'day.dart';

class Day4 extends Day {
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

Future<BingoGame> _loadDayInput() async => await rootBundle.loadString('assets/day4.txt').then(Day4Logic.parseInput);

class BingoGame {
  List<int> numbers;
  List<BingoBoard> boards;

  BingoGame(this.numbers, this.boards);

  int playPart1() {
    for (var number in numbers) {
      for (var board in boards) {
        var score = board.mark(number);
        if (score > -1) {
          return score;
        }
      }
    }
    throw Exception("Nobody won");
  }

  int playPart2() {
    for (var number in numbers) {
      for (int i = 0; i < boards.length; i++) {
        var score = boards[i].mark(number);
        if (score > -1) {
          boards.removeAt(i);
          i--;
          if (boards.isEmpty) {
            return score;
          }
        }
      }
    }
    throw Exception("Nobody won");
  }
}

class BingoBoard {
  List<List<Number>> numbers;

  BingoBoard(List<List<int>> rows) {
    numbers = rows.map((e) => e.map((e) => Number(e)).toList()).toList();
  }

  int mark(int number) {
    for (int y = 0; y < 5; y++) {
      for (int x = 0; x < 5; x++) {
        if (numbers[y][x].number == number) {
          numbers[y][x].marked = true;
          if (isBingo(x, y)) {
            return score(number);
          }
        }
      }
    }
    return -1;
  }

  bool isBingo(int x, int y) {
    bool row = numbers[y].map((e) => e.marked).reduce((value, element) => value && element);
    if (row) {
      return true;
    }
    for (int i = 0; i < 5; i++) {
      if (!numbers[i][x].marked) return false;
    }
    return true;
  }

  int score(int number) {
    int unmarkedSum = numbers
        .map((row) => row.map((e) => e.marked ? 0 : e.number).reduce((value, element) => value + element))
        .reduce((value, element) => value + element);
    return unmarkedSum * number;
  }
}

class Number {
  int number;
  bool marked = false;

  Number(this.number);

  @override
  String toString() {
    return "$number${marked ? "x" : ""}".padLeft(3);
  }
}

class Day4Logic {
  static BingoGame parseInput(String input) {
    var lines = input.split("\n").map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    var numbers = lines[0].split(",").map((e) => int.parse(e)).toList();
    var boards = <BingoBoard>[];
    var rows = <List<int>>[];
    var spaces = RegExp(" +");
    for (int i = 1; i < lines.length; i++) {
      rows.add(lines[i].split(spaces).map((e) => int.parse(e)).toList());
      if (rows.length == 5) {
        boards.add(BingoBoard(rows));
        rows = [];
      }
    }
    return BingoGame(numbers, boards);
  }
}
