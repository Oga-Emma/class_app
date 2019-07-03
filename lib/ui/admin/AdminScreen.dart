import 'package:flutter/material.dart';

import 'Classes.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: GestureDetector(
                onHorizontalDragEnd: (details) {},
                child: Text("Admin", textAlign: TextAlign.center)),
            elevation: 0.0,
            bottom: TabBar(
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Classes",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Events",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Excos",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            )),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                Expanded(child: Classes()),
                RaisedButton(
                  onPressed: () {},
                  child: Text("Add Lectrure"),
                ),
              ],
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
