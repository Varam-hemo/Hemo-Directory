import 'package:flutter/material.dart';

class MainMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color myColor;

  MainMenuItem({this.title, this.iconData, this.myColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          border: Border.all(color: myColor, width: 2.0),
          borderRadius: new BorderRadius.only(
            bottomRight: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 100,
                width: 110.0,
                color: myColor,
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 80.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "$title",
                style: TextStyle(
                    color: myColor, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
