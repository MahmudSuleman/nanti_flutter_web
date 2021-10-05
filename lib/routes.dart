import 'package:flutter/cupertino.dart';
import 'package:nanti_flutter_web/screens/client/client_list.dart';
import 'package:nanti_flutter_web/screens/dashboard/dashboard.dart';
import 'package:nanti_flutter_web/screens/device/device_list.dart';
import 'package:nanti_flutter_web/screens/dispatch/available_list.dart';
import 'package:nanti_flutter_web/screens/dispatch/dispatched_list.dart';
import 'package:nanti_flutter_web/screens/login.dart';
import 'package:nanti_flutter_web/screens/maintenance/maintenance_list.dart';

final Map<String, WidgetBuilder> routes = {
  // list pages
  DeviceList.routeName: (_) => DeviceList(),
  ClientList.routeName: (_) => ClientList(),
  MaintenanceList.routeName: (_) => MaintenanceList(),
  AvailableDispatch.routeName: (_) => AvailableDispatch(),
  DispatchedList.routeName: (_) => DispatchedList(),
  '/': (_) => Dashboard(),

  // auth routes
  Login.routeName: (_) => Login(),
};
