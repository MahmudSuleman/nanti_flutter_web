import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/device.dart';
import 'package:nanti_flutter_web/services/device_sevice.dart';

class DeviceProvider extends ChangeNotifier {
  List<Device> _devices = [];

  List<Device> get devices {
    DeviceService.allDevices().then((value) {
      _devices = value;
    });
    return [..._devices];
  }

  Future<void> store(Device device) async {
    // mock device adding
    print(devices.length);
    _devices.add(device);
    print(devices);
    notifyListeners();
  }
}
