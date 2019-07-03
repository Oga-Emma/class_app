import 'package:flutter/material.dart';

class AroundMe extends StatefulWidget {
  @override
  _AroundMeState createState() => _AroundMeState();
}

class _AroundMeState extends State<AroundMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Around me", textAlign: TextAlign.center)),
      body: Container(
        alignment: Alignment.center,
        child: Text("Around me"),
      ),
    );
  }
}
