import 'package:flutter/cupertino.dart';
import 'package:nanti_flutter_web/screens/admin/add_edit_dispatch.dart';

import 'package:nanti_flutter_web/screens/admin/dispatch_list.dart';
import 'package:nanti_flutter_web/screens/admin/maintenance_list.dart';
import 'package:nanti_flutter_web/screens/admin/user_list.dart';
import 'package:nanti_flutter_web/screens/company/company_list.dart';
import 'package:nanti_flutter_web/screens/device_list/device_list.dart';
import 'package:nanti_flutter_web/screens/login.dart';
import 'package:nanti_flutter_web/screens/user/user_device_list.dart';
import 'package:nanti_flutter_web/screens/user/user_maintenance_list.dart';

final Map<String, WidgetBuilder> routes = {
  // list pages
  DeviceList.routeName: (_) => DeviceList(),
  CompanyList.routeName: (_) => CompanyList(),
  DispatchList.routeName: (_) => DispatchList(),
  MaintenanceList.routeName: (_) => MaintenanceList(),
  UserList.routeName: (_) => UserList(),

  // user list pages
  UserDeviceList.routeName: (_) => UserDeviceList(),
  UserMaintenanceList.routeName: (_) => UserMaintenanceList(),

  // add update pages
  AddEditDispatch.routeName: (_) => AddEditDispatch(),

  // auth routes
  Login.routeName: (_) => Login(),
};
