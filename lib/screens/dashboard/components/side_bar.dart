import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nanti_flutter_web/screens/admin/company_list.dart';
import 'package:nanti_flutter_web/screens/admin/device_list.dart';
import 'package:nanti_flutter_web/screens/admin/dispatch_list.dart';
import 'package:nanti_flutter_web/screens/admin/maintenance_list.dart';

import 'menu_item.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/pos.svg',
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
          'DASHBOARD',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        MenuItem(
          navUrl: DeviceList.routeName,
          iconName: Icons.phone_android,
          iconLabel: 'Devices',
        ),
        SizedBox(
          height: 10,
        ),
        MenuItem(
          navUrl: CompanyList.routeName,
          iconName: Icons.house,
          iconLabel: 'Companies',
        ),
        SizedBox(
          height: 10,
        ),
        MenuItem(
          navUrl: DispatchList.routeName,
          iconName: Icons.send,
          iconLabel: 'Dispatches',
        ),
        SizedBox(
          height: 10,
        ),
        MenuItem(
          navUrl: MaintenanceList.routeName,
          iconName: Icons.settings,
          iconLabel: 'Maintenances',
        ),
      ],
    );
  }
}