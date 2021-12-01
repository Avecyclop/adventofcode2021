import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Day extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFF10101a),
        appBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.star, color: Colors.grey)),
            Tab(icon: Icon(Icons.star, color: Colors.amberAccent)),
          ],
        ),
        body: TabBarView(
          children: [
            part1(),
            part2(),
          ],
        ),
      ),
    );
  }

  @protected
  Widget part1();

  @protected
  Widget part2();
}
