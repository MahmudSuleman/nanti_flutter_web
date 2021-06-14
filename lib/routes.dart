import 'package:flutter/cupertino.dart';
import 'package:nanti_flutter_web/screens/add_edit_company.dart';
import 'package:nanti_flutter_web/screens/add_edit_device.dart';
import 'package:nanti_flutter_web/screens/company_list.dart';
import 'package:nanti_flutter_web/screens/device_list.dart';

final Map<String, WidgetBuilder> routes = {
  DeviceList.routeName: (_) => DeviceList(),
  AddEditDevice.routeName: (_) => AddEditDevice(),
  CompanyList.routeName: (_) => CompanyList(),
  AddEditCompany.routeName: (_) => AddEditCompany(),
};
