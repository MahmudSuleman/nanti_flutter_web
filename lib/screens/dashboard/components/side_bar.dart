import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/admin/company_list.dart';
import 'package:nanti_flutter_web/screens/admin/dispatch_list.dart';
import 'package:nanti_flutter_web/screens/admin/maintenance_list.dart';
import 'package:nanti_flutter_web/screens/device_list/device_list.dart';

import '../../../user_prefs.dart';
import '../../login.dart';
import 'menu_item.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/pos.png',
                    color: Colors.white,
                    height: 100,
                  ),
                  Text(
                    'Device Hub',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Menu Items',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            MenuItem(
              onTap: () {
                Navigator.of(context).pushNamed(DeviceList.routeName);
              },
              iconName: Icons.phone_android,
              iconLabel: 'Devices',
            ),
            SizedBox(
              height: 10,
            ),
            MenuItem(
              onTap: () {
                Navigator.of(context).pushNamed(CompanyList.routeName);
              },
              iconName: Icons.house,
              iconLabel: 'Companies',
            ),
            SizedBox(
              height: 10,
            ),
            MenuItem(
              onTap: () {
                Navigator.of(context).pushNamed(DispatchList.routeName);
              },
              iconName: Icons.send,
              iconLabel: 'Dispatches',
            ),
            SizedBox(
              height: 10,
            ),
            MenuItem(
              onTap: () {
                Navigator.of(context).pushNamed(MaintenanceList.routeName);
              },
              iconName: Icons.settings,
              iconLabel: 'Maintenances',
            ),
            SizedBox(
              height: 10,
            ),
            MenuItem(
              onTap: () {
                UserPrefs.clearUser().then((_) {
                  Navigator.pushReplacementNamed(context, Login.routeName);
                });
              },
              iconName: Icons.logout,
              iconLabel: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
