class Day3Logic {
  static List<List<bool>> parseInput(String input) {
    var bins = <List<bool>>[];
    input.split("\n").forEach((line) {
      if (line.trim().isNotEmpty) {
        var bin = line.trim().codeUnits.map((e) => e == 49).toList(); // "1" == 49
        bins.add(bin);
      }
    });
    return bins;
  }

  static part1(List<List<bool>> matrix) {
    var gamma = <bool>[];
    for (int x = 0; x < matrix[0].length; x++) {
      int sum = 0;
      for (int y = 0; y < matrix.length; y++) {
        if (matrix[y][x]) sum++;
      }
      gamma.add(sum >= matrix.length / 2);
    }
    var epsilon = gamma.map((e) => !e);

    var gammaRate = int.parse(gamma.fold("", (previous, element) => previous + (element ? "1" : "0")), radix: 2);
    var epsilonRate = int.parse(epsilon.fold("", (previous, element) => previous + (element ? "1" : "0")), radix: 2);
    return gammaRate * epsilonRate;
  }

  static part2(List<List<bool>> matrix) {
    var oxygen = matrix.toList();
    var co2 = matrix.toList();

    for (int x = 0; x < oxygen[0].length; x++) {
      if (oxygen.length == 1) {
        break;
      }
      int sum = 0;
      for (int y = 0; y < oxygen.length; y++) {
        if (oxygen[y][x]) sum++;
      }
      var typeBool = sum >= oxygen.length / 2;
      oxygen.removeWhere((element) => element[x] != typeBool);
    }

    for (int x = 0; x < co2[0].length; x++) {
      if (co2.length == 1) {
        break;
      }
      int sum = 0;
      for (int y = 0; y < co2.length; y++) {
        if (co2[y][x]) sum++;
      }
      var typeBool = sum < co2.length / 2;
      co2.removeWhere((element) => element[x] != typeBool);
    }

    var oxygenRating = int.parse(oxygen[0].fold("", (previous, element) => previous + (element ? "1" : "0")), radix: 2);
    var co2Rating = int.parse(co2[0].fold("", (previous, element) => previous + (element ? "1" : "0")), radix: 2);

    return oxygenRating * co2Rating;
  }
}
