import 'package:flutter/material.dart';
import 'package:flutter_login_app/theme/theme.dart' as Theme;
import 'package:flutter_login_app/src/welcome.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: Theme.buildCompanyTheme(),
      home: WelcomePage(),
    );
  }
}
