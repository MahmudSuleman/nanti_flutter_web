import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/company_list.dart';
import 'package:nanti_flutter_web/screens/device_list.dart';
import 'package:nanti_flutter_web/screens/dispatch_list.dart';
import 'package:nanti_flutter_web/screens/login.dart';
import 'package:nanti_flutter_web/screens/maintenance_list.dart';
import 'package:nanti_flutter_web/screens/user/user_device_list.dart';
import 'package:nanti_flutter_web/screens/user_list.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/user_prefs.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isAdmin = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AuthService.isAdmin().then((value) {
      setState(() {
        isAdmin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService.isAdmin().then((value) {
      setState(() {});
      isAdmin = value;
    });
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: isAdmin ? adminAppDrawer(context) : userAppDrawer(context),
      ),
    );
  }

  List<Widget> userAppDrawer(context) => [
        _createHeader(),
        _createDrawerItem(
          context,
          icon: Icons.home,
          text: 'Dashboard',
          onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.list,
          text: 'Device List',
          onTap: () {
            Navigator.pushNamed(context, UserDeviceList.routeName);
          },
        ),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.logout,
          text: 'Logout',
          onTap: () {
            UserPrefs.clearUser().then((_) {
              Navigator.pushReplacementNamed(context, Login.routeName);
            });
          },
        ),
      ];

  List<Widget> adminAppDrawer(context) => [
        _createHeader(),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.home,
          text: 'Dashboard',
          onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.phone_android,
          text: 'Devices',
          onTap: () {
            Navigator.pushNamed(context, DeviceList.routeName);
          },
        ),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.house,
          text: 'Companies',
          onTap: () {
            Navigator.pushNamed(context, CompanyList.routeName);
          },
        ),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.send,
          text: 'Dispatch',
          onTap: () {
            Navigator.pushNamed(context, DispatchList.routeName);
          },
        ),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.settings,
          text: 'Maintenance',
          onTap: () {
            Navigator.pushNamed(context, MaintenanceList.routeName);
          },
        ),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.person_add,
          text: 'Users',
          onTap: () {
            Navigator.pushNamed(context, UserList.routeName);
          },
        ),
        divider(),
        _createDrawerItem(
          context,
          icon: Icons.logout,
          text: 'Logout',
          onTap: () {
            UserPrefs.clearUser().then((_) {
              Navigator.pushReplacementNamed(context, Login.routeName);
            });
          },
        ),
      ];

  Divider divider() => Divider(
        color: Colors.green,
      );

  _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/pos.png'),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            right: 16.0,
            child: Text(
              "Menu",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(context,
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      tileColor: Theme.of(context).primaryColor,
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text!,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
