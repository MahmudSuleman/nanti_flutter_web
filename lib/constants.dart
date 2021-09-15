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
