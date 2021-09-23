import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/device_list/admin_device_list.dart';
import 'package:nanti_flutter_web/screens/device_list/user_device_list.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';

class DeviceList extends StatelessWidget {
  static String routeName = 'device-list';

  const DeviceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.isAdmin(),
      builder: (builder, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          return snapShot.data as bool ? AdminDeviceList() : UserDeviceList();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
