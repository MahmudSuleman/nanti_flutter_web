import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_lg.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_md.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_sm.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_xl.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';

import '../../constants.dart';
import 'components/admin_top_grid.dart';
import 'components/user_top_grid.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    double size = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: AuthService.isAdmin(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return buildDashboard(size, snapShot.data);
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  buildDashboard(size, isAdmin) {
    if (kLargeScreenSize(size)) {
      return ResponsiveLg(
          child: Container(
        child: isAdmin
            ? AdminTopGrid(
                perRowCount: 4,
              )
            : UserTopGrid(
                perRowCount: 3,
              ),
      ));
    }

    if (kMediumScreenSize(size)) {
      return ResponsiveMd(
        appBarTitle: 'Dashboard',
        child: isAdmin
            ? AdminTopGrid(
                perRowCount: 2,
              )
            : UserTopGrid(
                perRowCount: 2,
              ),
      );
    }
    if (kSmallScreenSize(size)) {
      return ResponsiveSm(
        appBarTitle: 'Dashboard',
        child: isAdmin
            ? AdminTopGrid(
                perRowCount: 1,
              )
            : UserTopGrid(
                perRowCount: 1,
              ),
      );
    }

    return ResponsiveXl(
      child: isAdmin
          ? AdminTopGrid(
              perRowCount: 4,
            )
          : UserTopGrid(
              perRowCount: 3,
            ),
    );
  }
}

// class DashboardSmallScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(55, 37, 73, 1),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(color: Color.fromRGBO(96, 96, 96, .8)),
//           child: Column(
//             children: [
//               Expanded(
//                   child: Container(
//                       child: TopGrid(
//                 mainGap: 20,
//                 perRowCount: 1,
//                 itemsCount: 4,
//                 chips: [
//                   DashboardChip(
//                     color: Colors.yellow,
//                     title: 'Devices',
//                     icon: Icons.phone_android,
//                     summary: '${['devices']}',
//                   ),
//                   DashboardChip(
//                     color: Colors.green,
//                     title: 'Maintenance',
//                     icon: Icons.settings,
//                     summary: '${['maintenances']}',
//                   ),
//                   DashboardChip(
//                     color: Color.fromRGBO(20, 20, 20, 1),
//                     title: 'Companies',
//                     icon: Icons.house,
//                     summary: '${['companies']}',
//                   ),
//                   DashboardChip(
//                     color: Colors.pink,
//                     title: 'Dispatches',
//                     icon: Icons.send,
//                     summary: '${['dispatches']}',
//                   ),
//                 ],
//               ))),
//               Container(
//                 child: Text('hello'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         backgroundColor: kAppBarBackground,
//       ),
//       drawer: SideBar(),
//     );
//   }
// }

// class DashboardMediumScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(55, 37, 73, 1),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(color: Color.fromRGBO(96, 96, 96, .8)),
//           child: Column(
//             children: [
//               Expanded(
//                   child: Container(
//                       child: TopGrid(
//                 mainGap: 10,
//                 perRowCount: 2,
//                 itemsCount: 4,
//                 chips: [],
//               ))),
//               Container(
//                 child: Text('hello'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         backgroundColor: Color.fromRGBO(55, 37, 73, 1),
//       ),
//       drawer: SideBar(),
//     );
//   }
// }
