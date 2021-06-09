import 'package:flutter/cupertino.dart';
import 'package:nanti_flutter_web/screens/add_device.dart';
import 'package:nanti_flutter_web/screens/device_list.dart';

final Map<String, WidgetBuilder> routes = {
  DeviceList.routeName: (_) => DeviceList(),
  AddDevice.routeName: (_) => AddDevice(),
};
