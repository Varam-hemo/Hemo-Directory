import 'package:flutter/material.dart';
import 'package:hemo_directory/ui/widgets/MyScaffold.dart';

class HTCPage extends StatefulWidget {
  HTCPage({Key key}) : super(key: key);

  @override
  _HTCPageState createState() => _HTCPageState();
}

class _HTCPageState extends State<HTCPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: Container(
        child: Text("HTC"),
      ),
    );
  }
}
