import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/device.dart';

class DeviceProvider extends ChangeNotifier {
  List<Device> _devices = [
    Device(
        id: '1',
        manufactuer: 'manufactuer 1',
        name: 'name 1',
        serialNumber: 'serialNumber 1'),
    Device(
        id: '2',
        manufactuer: 'manufactuer 2',
        name: 'name 2',
        serialNumber: 'serialNumber 2'),
    Device(
        id: '3',
        manufactuer: 'manufactuer 3',
        name: 'name 3',
        serialNumber: 'serialNumber 3'),
  ];

  List<Device> get devices {
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
