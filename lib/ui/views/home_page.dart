import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hemo_directory/core/models/user_repository.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () => Provider.of<UserRepository>(context).signOut(),
            )
          ],
        ),
      ),
    );
  }
}