import 'package:flutter/material.dart';
import 'package:hemo_directory/ui/widgets/MyScaffold.dart';

class DirectoryPage extends StatefulWidget {
  DirectoryPage({Key key}) : super(key: key);

  @override
  _DirectoryPageState createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: Container(
        child: Text("Directory"),
      ),
    );
  }
}
