import 'dart:async';

import 'package:adventofcode2021/lib.dart';
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

class _Part1State extends State<_Part1> {
  BingoGame _bingoGame;
  Timer _timer;
  int _winner;

  @override
  void initState() {
    super.initState();
    _loadDayInput().then((value) {
      _bingoGame = value;
      _timer = Timer.periodic(Duration(milliseconds: 250), (t) {
        var winningBoard = _bingoGame.part1drawNumber();
        if (winningBoard > -1) {
          _winner = winningBoard;
          t.cancel();
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      itemBuilder: (_, index) => bingoBoard(index),
      itemCount: 100,
    );
  }

  Widget bingoBoard(int index) {
    if (_winner == index) {
      return Icon(Icons.check, color: Colors.green);

    }
    if (_bingoGame == null) {
      return Center(child: WhiteText("?"));
    }
    var board = _bingoGame.boards[index];
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      itemBuilder: (_, index) {
        var number = board.numbers[index ~/ 5][index % 5];
        var text = number.marked ? "  " : number.number;
        return WhiteText("$text".padLeft(2), fontSize: 10);
      },
      itemCount: 25,
      padding: EdgeInsets.all(5),
    );
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
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<BingoGame> _loadDayInput() async => await rootBundle.loadString('assets/day4.txt').then(Day4Logic.parseInput);

class BingoGame {
  List<int> numbers;
  List<BingoBoard> boards;
  int _round = 0;

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

  int part1drawNumber() {
    var number = numbers[_round++];
    for (int i = 0; i < boards.length; i++) {
      if (boards[i].mark(number) > -1) {
        return i;
      }
    }
    return -1;
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
