class Counter {
  var _count = 0;

  get() => _count;

  addAndGet(int delta) {
    _count += delta;
    return _count;
  }
}

class Day16Logic {
  static String parseInput(String input) => input
      .split('\n')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .expand((line) => line.split(''))
      .map((char) => int.parse(char, radix: 16))
      .map((e) => e.toRadixString(2).padLeft(4, '0'))
      .join();

  static part1(String bits) {
    var pos = Counter();
    var versions = <int>[];
    parsePacket1(bits, pos, versions);
    return versions.reduce((value, element) => value + element);
  }

  static parsePacket1(String bits, Counter pos, List<int> versions) {
    var version = getNext(3, bits, pos);
    versions.add(version);
    var typeId = getNext(3, bits, pos);
    if (typeId == 4) {
      var pad;
      do {
        pad = getNext(1, bits, pos);
        pos.addAndGet(4);
      } while (pad == 1);
    } else {
      var lengthTypeId = getNext(1, bits, pos);
      if (lengthTypeId == 0) {
        var bitLength = getNext(15, bits, pos);
        parsePacketsByLength(bits, pos, bitLength, versions);
      } else {
        var numberOfSubPackets = getNext(11, bits, pos);
        parsePacketsByAmount(bits, pos, numberOfSubPackets, versions);
      }
    }
  }

  static parsePacketsByLength(String bits, Counter pos, int bitLength, List<int> versions) {
    int end = pos.get() + bitLength;
    while (pos.get() < end) {
      parsePacket1(bits, pos, versions);
    }
  }

  static parsePacketsByAmount(String bits, Counter pos, int numberOfSubPackets, List<int> versions) {
    for (int i = 0; i < numberOfSubPackets; i++) {
      parsePacket1(bits, pos, versions);
    }
  }

  static part2(String bits) {
    var pos = Counter();
    var packets = [];
    parsePacket2(bits, pos, packets);
    //print(packets);
    while (packets.length > 1) {
      solve(packets);
      //print(packets);
    }
    return packets[0];
  }

  static parsePacket2(String bits, Counter pos, List packets) {
    pos.addAndGet(3);
    var typeId = getNext(3, bits, pos);
    if (typeId == 4) {
      var pad;
      var literal = "";
      do {
        pad = getNext(1, bits, pos);
        literal = "$literal${bits.substring(pos.get(), pos.addAndGet(4))}";
      } while (pad == 1);
      packets.add(int.parse(literal, radix: 2));
    } else {
      packets.add(type(typeId));
      packets.add([]);
      var lengthTypeId = getNext(1, bits, pos);
      if (lengthTypeId == 0) {
        var bitLength = getNext(15, bits, pos);
        parsePacketsByLength2(bits, pos, bitLength, packets.last);
      } else {
        var numberOfSubPackets = getNext(11, bits, pos);
        parsePacketsByAmount2(bits, pos, numberOfSubPackets, packets.last);
      }
    }
  }

  static parsePacketsByLength2(String bits, Counter pos, int bitLength, List packets) {
    int end = pos.get() + bitLength;
    while (pos.get() < end) {
      parsePacket2(bits, pos, packets);
    }
  }

  static parsePacketsByAmount2(String bits, Counter pos, int numberOfSubPackets, List packets) {
    for (int i = 0; i < numberOfSubPackets; i++) {
      parsePacket2(bits, pos, packets);
    }
  }

  static solve(List packets) {
    for (int i = 0; i < packets.length; i++) {
      if (packets[i] is String) {
        if (isAllInts(packets[i + 1])) {
          var op = packets.removeAt(i);
          var args = packets.removeAt(i);
          packets.insert(i, calculate(op, args));
          i--;
        } else {
          solve(packets[i + 1]);
        }
      }
    }
  }

  static int calculate(String operator, List args) {
    switch (operator) {
      case 'sum':
        return args.reduce((value, element) => value + element);
      case 'mul':
        return args.reduce((value, element) => value * element);
      case 'min':
        return args.reduce((value, element) => value < element ? value : element);
      case 'max':
        return args.reduce((value, element) => value > element ? value : element);
      case 'gt':
        return args[0] > args[1] ? 1 : 0;
      case 'lt':
        return args[0] < args[1] ? 1 : 0;
      case 'eq':
        return args[0] == args[1] ? 1 : 0;
      default:
        throw Exception('Can only solve numbers');
    }
  }

  static type(int typeId) {
    switch (typeId) {
      case 0:
        return 'sum';
      case 1:
        return 'mul';
      case 2:
        return 'min';
      case 3:
        return 'max';
      case 5:
        return 'gt';
      case 6:
        return 'lt';
      case 7:
        return 'eq';
    }
  }

  static isAllInts(List list) => list.every((element) => element is int);

  static getNext(int size, String bits, Counter pos) => int.parse(bits.substring(pos.get(), pos.addAndGet(size)), radix: 2);
}
