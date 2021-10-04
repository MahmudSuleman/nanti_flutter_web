import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/manufacturer.dart';
import 'package:nanti_flutter_web/services/manufacturer_service.dart';

class ManufacturerProvider extends ChangeNotifier {
  List<Manufacturer> _manufacturers = [];

  void init() {
    ManufacturerService.allManufacturers().then((value) {
      _manufacturers = value;
    });
  }

  List<Manufacturer> get allManufacturers {
    return [..._manufacturers];
  }
}
