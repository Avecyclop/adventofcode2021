import 'dart:math';

class Day15Logic {
  static List<List<int>> parseInput(String input) => input
      .split('\n')
      .map((e) => e.trim())
      .where((element) => element.isNotEmpty)
      .map((line) => line.split('').map((e) => int.parse(e)).toList())
      .toList();

  static part1(List<List<int>> cave) {
    int intMax = pow(2, 62);
    var riskLevels = List.generate(cave.length, (y) => List.generate(cave[0].length, (x) => intMax));
    addOuterLayer(cave);
    addOuterLayer(riskLevels);

    cave[1][1] = 0;
    traverseFull(cave, riskLevels, 1, 1, 0, 1000);

    var lastRow = riskLevels[riskLevels.length - 2];
    return lastRow[lastRow.length - 2];
  }

  static traverseFull(List<List<int>> cave, List<List<int>> riskLevels, int x, int y, int riskLevel, int depth) {
    if (depth <= 0) return;
    var newRiskLevel = riskLevel + cave[y][x];
    if (riskLevels[y][x] <= newRiskLevel) return;
    riskLevels[y][x] = newRiskLevel;
    traverseFull(cave, riskLevels, x + 1, y, newRiskLevel, depth - 1);
    traverseFull(cave, riskLevels, x - 1, y, newRiskLevel, depth - 1);
    traverseFull(cave, riskLevels, x, y + 1, newRiskLevel, depth - 1);
    traverseFull(cave, riskLevels, x, y - 1, newRiskLevel, depth - 1);
  }

  static part2(List<List<int>> cave) {
    var maxY = cave.length;
    var maxX = cave[0].length;
    var newCave = List.generate(maxY * 5, (y) {
      return List.generate(maxX * 5, (x) {
        var risk = cave[y % maxY][x % maxX] + y ~/ maxY + x ~/ maxX;
        return risk <= 9 ? risk : risk % 9;
      }, growable: true);
    }, growable: true);

    int intMax = pow(2, 62);
    var riskLevels = List.generate(newCave.length, (y) => List.generate(newCave[0].length, (x) => intMax));

    addOuterLayer(newCave);
    addOuterLayer(riskLevels);
    newCave[1][1] = 0;

    traverseDownRight(List<List<int>> cave, List<List<int>> riskLevels, int x, int y, int riskLevel) {
      var newRiskLevel = riskLevel + cave[y][x];
      if (riskLevels[y][x] <= newRiskLevel) return;
      riskLevels[y][x] = newRiskLevel;
      traverseDownRight(cave, riskLevels, x + 1, y, newRiskLevel);
      traverseDownRight(cave, riskLevels, x, y + 1, newRiskLevel);
    }

    traverseDownRight(newCave, riskLevels, 1, 1, 0);

    var points;
    do {
      points = 0;
      for (int y = 1; y < riskLevels.length - 1; y++) {
        for (int x = 1; x < riskLevels[0].length - 1; x++) {
          var risk = newCave[y][x];
          var currentRisk = riskLevels[y][x];

          var right = riskLevels[y][x + 1];
          if (right != -1) {
            var righter = right + risk;
            if (currentRisk > righter) {
              points++;
              traverseFull(newCave, riskLevels, x, y, right, 100);
            }
          }

          var down = riskLevels[y + 1][x];
          if (down != -1) {
            var downer = down + risk;
            if (currentRisk > downer) {
              points++;
              traverseFull(newCave, riskLevels, x, y, down, 100);
            }
          }

          var left = riskLevels[y][x - 1];
          if (left != -1) {
            var lefter = left + risk;
            if (currentRisk > lefter) {
              points++;
              traverseFull(newCave, riskLevels, x, y, left, 100);
            }
          }

          var up = riskLevels[y - 1][x];
          if (up != -1) {
            var upper = up + risk;
            if (currentRisk > upper) {
              points++;
              traverseFull(newCave, riskLevels, x, y, up, 100);
            }
          }
        }
      }
    } while (points != 0);

    var lastRow = riskLevels[riskLevels.length - 2];
    return lastRow[lastRow.length - 2];
  }

  static addOuterLayer(List<List<int>> cave) {
    cave.forEach((e) => e.insert(0, -1));
    cave.forEach((e) => e.add(-1));
    cave.insert(0, List.generate(cave[0].length, (i) => -1));
    cave.add(List.generate(cave[0].length, (i) => -1));
  }

  static printCave(List<List<int>> cave) {
    for (int y = 1; y < cave.length - 1; y++) {
      print(cave[y].sublist(1, cave[y].length - 1));
    }
  }
}

/*
var stack = <Tuple3<int, int, int>>{};
stack.add(Tuple3(1, 1, 0));
while (stack.isNotEmpty) {
  var traverse = stack.first;
  stack.remove(traverse);
  var x = traverse.item1;
  var y = traverse.item2;
  var riskLevel = traverse.item3 + newCave[y][x];
  if (riskLevels[y][x] > riskLevel) {
    riskLevels[y][x] = riskLevel;
    stack.add(Tuple3(x + 1, y, riskLevel));
    stack.add(Tuple3(x, y + 1, riskLevel));

    var tileX = x ~/ maxX;
    var tileY = y ~/ maxY;
    if (tileX - tileY < -2) stack.add(Tuple3(x - 1, y, riskLevel));
    if (tileY - tileX < -2) stack.add(Tuple3(x, y - 1, riskLevel));
  }
}
*/
