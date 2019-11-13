import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final bool isHome;

  MyScaffold({Key key, this.child, this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(
          child: Text("Hemophilia Federation (India)"),
        ),
        leading: new IconButton(
          icon: new Image.asset("assets/images/logo.png"),
          tooltip: 'Home',
          onPressed: () {
            if (isHome == null || !isHome) {
              Navigator.pushNamed(context, "/");
            }
          },
        ),
      ),
      body: child,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Menu',
        hoverColor: Colors.blue,
        child: new Icon(
          Icons.menu,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
