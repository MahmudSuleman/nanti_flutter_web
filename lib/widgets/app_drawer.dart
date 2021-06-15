import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/company_list.dart';
import 'package:nanti_flutter_web/screens/device_list.dart';
import 'package:nanti_flutter_web/screens/dispatch_list.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
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
        ],
      ),
    );
  }

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
