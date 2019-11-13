import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hemo_directory/core/models/user_repository.dart';
import 'package:hemo_directory/ui/widgets/MainMenuItem.dart';
import 'package:hemo_directory/ui/widgets/MyScaffold.dart';
import 'package:hemo_directory/ui/widgets/splash.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          print("Switch ${user.status}");
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return UserInfoPage(user: user.user);
            default:
              return new Container(
                color: Colors.redAccent,
              );
          }
        },
      ),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final FirebaseUser user;

  const UserInfoPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      isHome: true,
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/directory');
                },
                child: MainMenuItem(
                  title: "Directory",
                  iconData: Icons.contacts,
                  myColor: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/htc');
                },
                child: MainMenuItem(
                  title: "HTC",
                  iconData: Icons.local_hospital,
                  myColor: Colors.brown,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
                child: MainMenuItem(
                  title: "About",
                  iconData: Icons.account_box,
                  myColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
