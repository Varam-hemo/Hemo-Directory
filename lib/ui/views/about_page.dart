import 'package:flutter/material.dart';
import 'package:hemo_directory/ui/widgets/MyScaffold.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: Container(
        child: Text("HTC"),
      ),
    );
  }
}
