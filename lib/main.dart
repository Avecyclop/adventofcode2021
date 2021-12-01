import 'package:flutter/material.dart';

import 'day1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          primary: true,
          appBar: AppBar(
            title: Text('Advent of Code 2021'),
            bottom: TabBar(
              tabs: [
                Tab(text: "Day 1")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Day1()
            ],
          ),
        ),
      ),
    );
  }
}
