import 'package:flutter/material.dart';
import 'package:flutter_login_app/theme/colors.dart';

ThemeData buildCompanyTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: kPrimaryColor,
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, kWhiteColor),
    primaryIconTheme: base.iconTheme.copyWith(color: kWhiteColor),
    buttonColor: kSecondaryColor,
    accentColor: kPrimaryColor,
    scaffoldBackgroundColor: kWhiteColor,
    cardColor: Colors.white,
    textSelectionColor: kSecondaryColor,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: kSecondaryColor,
    ),
    textSelectionHandleColor: kSecondaryColor,
    accentTextTheme: _buildTextTheme(base.accentTextTheme, kWhiteColor),
    textTheme: _buildTextTheme(base.textTheme, kPrimaryColor),
  );
}

TextTheme _buildTextTheme(TextTheme base, Color color) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Raleway',
        displayColor: color,
        bodyColor: color,
      );
}