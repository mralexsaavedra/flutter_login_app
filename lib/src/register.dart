import 'package:flutter/material.dart';
import 'package:flutter_login_app/theme/colors.dart';
import 'package:validate/validate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_app/providers/auth.dart';
import 'package:flutter_login_app/src/home.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _LoginData {
  String username = '';
  String email = '';
  String password = '';
  String repeatPassword = '';
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formUserKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _formPasswordKey = new GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final AuthImpl _auth = new Auth();
  _LoginData _data = new _LoginData();
  bool _next = false;

  String _validateUsername(String value) {
    if (value.length < 6) {
      return 'Invalid username';
    }

    return null;
  }

  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'Invalid email';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 6) {
      return 'Invalid password';
    }

    return null;
  }

  String _validateRepeatPassword(String value) {
    if (value.length < 6 || value != passwordController.text) {
      return 'The password are not equal';
    }

    return null;
  }

  Widget _buildFormLogin() {
    return Form(
      key: this._formUserKey,
      child: Column(
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(primaryColor: kBlackColor),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: kWhiteColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhiteColor),
                ),
                enabledBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhiteColor),
                ),
              ),
              validator: _validateUsername,
              onSaved: (String value) {
                this._data.username = value;
              }
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Theme(
            data: Theme.of(context).copyWith(primaryColor: kBlackColor),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email address',
                labelStyle: TextStyle(color: kWhiteColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhiteColor),
                ),
                enabledBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhiteColor),
                ),
              ),
              validator: _validateEmail,
              onSaved: (String value) {
                this._data.email = value;
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordForm() {
    return Form(
      key: this._formPasswordKey,
      child: Column(
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(primaryColor: kBlackColor),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: kWhiteColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhiteColor),
                ),
                enabledBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhiteColor),
                ),
              ),
              validator: _validatePassword,
              onSaved: (String value) {
                this._data.password = value;
              }
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Theme(
            data: Theme.of(context).copyWith(primaryColor: kBlackColor),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Repeat password',
                labelStyle: TextStyle(color: kWhiteColor),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhiteColor),
                ),
                enabledBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: kWhiteColor),
                ),
              ),
              validator: _validateRepeatPassword,
              onSaved: (String value) {
                this._data.repeatPassword = value;
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          OutlineButton(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: kWhiteColor,
                ),
              ],
            ),
            onPressed: () {
              if (this._formUserKey.currentState.validate()) {
                _formUserKey.currentState.save();
                setState(() {
                  _next = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          OutlineButton(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Icon(
                  Icons.check,
                  color: kWhiteColor,
                ),
              ],
            ), onPressed: () {
              if (this._formPasswordKey.currentState.validate()) {
                _formPasswordKey.currentState.save();
                _auth.signUp(_data.email, _data.password)
                  .then((FirebaseUser user) =>
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(user: user)),
                    )
                  )
                  .catchError((e) => print(e));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: kDegradedColors,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 120.0),
              Center(
                child: Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: kWhiteColor,
                  ),
                ),
              ),
              SizedBox(height: 60.0),
              (!_next
                ? _buildFormLogin()
                : _buildPasswordForm()
              ),
              SizedBox(height: 20.0),
              (!_next
                ? _buildNextButton()
                : _buildRegisterButton()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
