import 'dart:math';

class Target {
  int x1;
  int x2;
  int y1;
  int y2;

  int maxY = 0;
  int probes = 0;

  Target(this.x1, this.x2, this.y1, this.y2);

  isIn(Probe probe) {
    var isIn = x1 <= probe.x && probe.x <= x2 && y1 <= probe.y && probe.y <= y2;
    if (isIn) {
      maxY = max(probe.maxY, maxY);
      probes++;
    }
    return isIn;
  }

  past(Probe probe) {
    var pastX = probe.dx == 0 && (probe.x < x1 || x2 < probe.x);
    var pastY = probe.dy < 0 && (probe.y < y1);
    return pastX || pastY;
  }
}

class Probe {
  int x = 0;
  int y = 0;
  int dx;
  int dy;

  int maxY = 0;

  Probe(this.dx, this.dy);

  travel() {
    x += dx;
    y += dy;
    if (dx > 0) {
      dx--;
    }
    dy--;
    maxY = max(y, maxY);
  }
}

class Day17Logic {
  static Target parseInput(String input) {
    var target = new RegExp(r"^target area: x=(\d+)..(\d+), y=(-\d+)..(-\d+)$");
    var match = target.allMatches(input).first;
    var x1 = int.parse(match.group(1));
    var x2 = int.parse(match.group(2));
    var y1 = int.parse(match.group(3));
    var y2 = int.parse(match.group(4));
    return Target(x1, x2, y1, y2);
  }

  static part1(Target target) {
    var probes = <Probe>{};
    for (int xVel = 1; xVel < 1000; xVel++) {
      for (int yVel = 1; yVel < 1000; yVel++) {
        probes.add(Probe(xVel, yVel));
      }
    }
    for (int t = 0; t < 500; t++) {
      probes.forEach((probe) {
        probe.travel();
        target.isIn(probe);
      });
      //probes.removeWhere((probe) => target.past(probe));
    }
    return target.maxY;
  }

  static part2(Target target) {
    var probes = <Probe>[];
    for (int xVel = 1; xVel < 1000; xVel++) {
      for (int yVel = -1000; yVel < 1000; yVel++) {
        probes.add(Probe(xVel, yVel));
      }
    }
    for (int t = 0; t < 500; t++) {
      probes.forEach((probe) => probe.travel());
      probes.removeWhere((probe) => target.isIn(probe) || target.past(probe));
    }
    return target.probes;
  }
}
