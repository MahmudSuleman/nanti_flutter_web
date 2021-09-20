import 'dart:io';

import 'package:flutter/material.dart';

final kPageHeaderTextStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

// final kBaseUrl = 'http://10.0.2.2/nanti_flutter_web_api/endpoint/';
final kBaseUrl = 'http://localhost/nanti_flutter_web_api/endpoint/';
// final kBaseUrl = 'http://92.205.22.26:75/endpoint/';
final kHeaders = {
  HttpHeaders.contentTypeHeader: 'application/json',
};

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
