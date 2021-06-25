import 'package:flutter/cupertino.dart';
import 'package:nanti_flutter_web/screens/add_edit_company.dart';
import 'package:nanti_flutter_web/screens/add_edit_device.dart';
import 'package:nanti_flutter_web/screens/add_edit_dispatch.dart';
import 'package:nanti_flutter_web/screens/company_list.dart';
import 'package:nanti_flutter_web/screens/device_list.dart';
import 'package:nanti_flutter_web/screens/dispatch_list.dart';
import 'package:nanti_flutter_web/screens/login.dart';
import 'package:nanti_flutter_web/screens/maintenance_list.dart';
import 'package:nanti_flutter_web/screens/user/user_device_list.dart';
import 'package:nanti_flutter_web/screens/user_list.dart';

final Map<String, WidgetBuilder> routes = {
  // list pages
  DeviceList.routeName: (_) => DeviceList(),
  CompanyList.routeName: (_) => CompanyList(),
  DispatchList.routeName: (_) => DispatchList(),
  MaintenanceList.routeName: (_) => MaintenanceList(),
  UserList.routeName: (_) => UserList(),

  // user list pages
  UserDeviceList.routeName: (_) => UserDeviceList(),

  // add update pages
  AddEditDevice.routeName: (_) => AddEditDevice(),
  AddEditCompany.routeName: (_) => AddEditCompany(),
  AddEditDispatch.routeName: (_) => AddEditDispatch(),

  // auth routes
  Login.routeName: (_) => Login(),
};
