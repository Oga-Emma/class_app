import 'package:flutter/material.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notificaton", textAlign: TextAlign.center)),
      body: Container(
        alignment: Alignment.center,
        child: Text("Notificaton"),
      ),
    );
  }
}
