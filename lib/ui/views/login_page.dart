import 'package:flutter/material.dart';
import 'package:hemo_directory/core/models/user_repository.dart';
import 'package:provider/provider.dart';

class NameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Name can't be empty" : null;
  }
}

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Email can't be empty" : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? "Password can't be empty" : null;
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;
  FormType _formType = FormType.login;
  bool _isIos;
  bool _isLoading;
  String _errorMessage;
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid, Email: $_email, password: $_password");
      return true;
    } else {
      print("Form is invalid");
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() {
        _errorMessage = "";
        _isLoading = true;
      });
      try {
        if (_formType == FormType.login) {
          bool userId =
              await Provider.of<UserRepository>(context).signIn(_email, _password);
          print("Signed in: $userId");
        } else {
          bool user = await Provider.of<UserRepository>(context).createUserWithEmailAndPassword(
              _email, _password, _name);

          print("Created user: $user");
          print("Created User");
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {}
  }

  void googleSignIn() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    try {
      bool userId = await Provider.of<UserRepository>(context).signInWithGoogle();
      print("Signed in: $userId");
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void moveToRegister() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Factor Status Login"),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return new Container(
        child: Center(child: CircularProgressIndicator()),
        color: Color.fromRGBO(0, 0, 0, 100),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showBody() {
    var myWidgets = buildInputs() + buildButtons() + [_showErrorMessage()];

    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new ListView(children: [
          new Form(
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: myWidgets,
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
              child: SizedBox(
                height: 40.0,
                child: new RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: _formType == FormType.login
                      ? new Text('Sign In with Google',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white))
                      : new Text('Sign up with Google',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white)),
                  onPressed: googleSignIn,
                ),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
              child: SizedBox(
                height: 40.0,
                child: new RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Theme.of(context).accentColor,
                  child: _formType == FormType.login
                      ? new Text('Sign In with Facebook',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white))
                      : new Text('Sign up with Facebook',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white)),
                  onPressed: null,
                ),
              ))
        ]));
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  List<Widget> buildInputs() {
    List<Widget> inputs = new List<Widget>();

    if (FormType.register == _formType) {
      inputs.add(Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Name',
              icon: new Icon(
                Icons.input,
                color: Colors.grey,
              )),
          validator: NameFieldValidator.validate,
          onSaved: (value) => _name = value.trim(),
        ),
      ));
    }
    inputs.addAll([
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Email',
              icon: new Icon(
                Icons.mail,
                color: Colors.grey,
              )),
          validator: EmailFieldValidator.validate,
          onSaved: (value) => _email = value.trim(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Password',
              icon: new Icon(
                Icons.lock,
                color: Colors.grey,
              )),
          validator: PasswordFieldValidator.validate,
          onSaved: (value) => _password = value.trim(),
        ),
      ),
    ]);
    return inputs;
  }

  List<Widget> buildButtons() {
    return [
      Padding(
          padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
          child: SizedBox(
            height: 40.0,
            child: new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Theme.of(context).accentColor,
              child: _formType == FormType.login
                  ? new Text('Login',
                      style: new TextStyle(fontSize: 20.0, color: Colors.white))
                  : new Text('Create account',
                      style:
                          new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: validateAndSubmit,
            ),
          )),
      FlatButton(
        child: _formType == FormType.login
            ? new Text('Create an account',
                style:
                    new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
            : new Text('Have an account? Sign in',
                style:
                    new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: _formType == FormType.login ? moveToRegister : moveToLogin,
      ),
    ];
  }
}
