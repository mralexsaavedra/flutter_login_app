import 'package:flutter/material.dart';
import 'package:flutter_login_app/theme/colors.dart';
import 'package:flutter_login_app/src/login.dart';
import 'package:flutter_login_app/src/register.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: 250.0),
              Center(
                child: Text(
                  'Flutter Login App Example',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: kWhiteColor,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                height: 40.0,
                child: new RaisedButton(
                  elevation: 8.0,
                  shape: StadiumBorder(),
                  child: Text(
                    'Create account',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: kBlueColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
              ),
              Center(
                child: Container(
                  margin: new EdgeInsets.symmetric(horizontal: 15.0),
                  height: 40.0,
                  child: GestureDetector(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: kWhiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
