import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final kPageHeaderTextStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

TextStyle kCalculatePageHeaderTextStyle(double size) => TextStyle(
    fontSize: kCalculateFont(size) * 1.5, fontWeight: FontWeight.bold);

// final kBaseUrl = 'https://nanti-flutter-web-laravel-api.herokuapp.com/api';
final kBaseUrl = 'http://localhost:8000/api';
final kHeaders = {HttpHeaders.contentTypeHeader: 'application/json'};

final kScaffoldBackground = Color.fromRGBO(96, 96, 96, .8);

final kAppBarBackground = Color.fromRGBO(55, 37, 73, 0.9019607843137255);
final kAppBarBackgroundOld = Color.fromRGBO(55, 37, 73, 1);

//colors
final primaryColor = Color(0x3e2723);
final primaryLightColor = Color(0x6a4f4b);
final primaryDarkColor = Color(0x1b0000);
final primaryTextColor = Color(0xfffff);

// screen sizes
bool kSmallScreenSize(double size) => size <= 500;
bool kMediumScreenSize(double size) => size > 500 && size <= 900;
bool kLargeScreenSize(double size) => size > 900;

//  calculate font size
double kCalculateFont(double size) {
  if (kSmallScreenSize(size)) return 12;
  if (kMediumScreenSize(size)) return 15;
  if (kLargeScreenSize(size)) return 20;
  return 12;
}

ButtonStyle kElevatedButtonStyle({Color? color}) {
  return ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) {
    return color ?? kAppBarBackground;
  }));
}

kInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      color: kAppBarBackground,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kAppBarBackground),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kAppBarBackground, width: 3),
    ),
  );
}

kDivider() {
  return Divider(
    thickness: 2,
    height: 20,
    color: kAppBarBackground,
  );
}

kPageHeaderTitle(String title, double size) => Text(
      title,
      style: kCalculatePageHeaderTextStyle(size),
      textAlign: TextAlign.center,
    );

kFormatDate(DateTime date) {
  return DateFormat('yyyy/MM/dd').format(date);
}

kSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    ),
  );
}

kFailureSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ),
  );
}

kPopTrue(BuildContext context) {
  Navigator.pop(context, true);
}

kPopFalse(BuildContext context) {
  Navigator.pop(context, false);
}

// kAddItemButton(String title) =>
