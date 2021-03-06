import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/client/client_list.dart';
import 'package:nanti_flutter_web/screens/device/device_list.dart';
import 'package:nanti_flutter_web/screens/dispatch/available_list.dart';
import 'package:nanti_flutter_web/screens/dispatch/dispatched_list.dart';
import 'package:nanti_flutter_web/screens/dispatch_note/dispatch_note_list.dart';
import 'package:nanti_flutter_web/screens/maintenance/maintenance_list.dart';
import 'package:nanti_flutter_web/screens/user/user_list.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';

import '../../../user_prefs.dart';
import '../../login.dart';
import 'menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool showHiddenMenu = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.isAdmin(),
      builder: (builder, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
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
                      Navigator.of(context).pushNamed('/');
                    },
                    iconName: Icons.home,
                    iconLabel: 'Home',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MenuItem(
                    onTap: () {
                      Navigator.of(context).pushNamed(UserList.routeName);
                    },
                    iconName: Icons.person_add,
                    iconLabel: 'Users',
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
                  if (snapShot.data as bool)
                    MenuItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(ClientList.routeName);
                      },
                      iconName: Icons.house,
                      iconLabel: 'Clients',
                    ),
                  if (snapShot.data as bool)
                    SizedBox(
                      height: 10,
                    ),
                  if (snapShot.data as bool)
                    MenuItem(
                      onTap: () {
                        // toggle available and dispatched devices
                        setState(() {
                          showHiddenMenu = !showHiddenMenu;
                        });
                      },
                      iconName: Icons.send,
                      iconLabel: 'Dispatches',
                    ),
                  if (snapShot.data as bool)
                    SizedBox(
                      height: 10,
                    ),
                  if (showHiddenMenu)
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          MenuItem(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(DispatchNoteList.routeName);
                            },
                            iconName: Icons.note_add,
                            iconLabel: 'Dispatch Notes',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          MenuItem(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AvailableDispatch.routeName);
                            },
                            iconName: Icons.event_available,
                            iconLabel: 'Available',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MenuItem(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(DispatchedList.routeName);
                            },
                            iconName: Icons.event_busy,
                            iconLabel: 'Dispatched',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  MenuItem(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(MaintenanceList.routeName);
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
                        Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) => Login()),
                          ModalRoute.withName('/login'),
                        );
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

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
