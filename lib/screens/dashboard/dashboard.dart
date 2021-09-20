import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_lg.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_md.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_sm.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive_xl.dart';

import '../../constants.dart';
import 'components/side_bar.dart';
import 'components/top_grid.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return buildDashboard(size);
  }

  buildDashboard(size) {
    if (kLargeScreenSize(size)) {
      return ResponsiveLg(
          child: Container(
        child: TopGrid(
          itemsCount: 4,
          perRowCount: 4,
          mainGap: 50,
        ),
      ));
    }

    if (kMediumScreenSize(size)) {
      return ResponsiveMd(
        child: Text('medium'),
      );
    }
    if (kSmallScreenSize(size)) {
      return ResponsiveSm(
        child: Text('small'),
      );
    }

    return ResponsiveXl(
      child: Text('xlarge'),
    );
  }
}

class DashboardSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(55, 37, 73, 1),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(96, 96, 96, .8)),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      child:
                          TopGrid(mainGap: 20, perRowCount: 1, itemsCount: 4))),
              Container(
                child: Text('hello'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: kAppBarBackground,
      ),
      drawer: SideBar(),
    );
  }
}

class DashboardMediumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(55, 37, 73, 1),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(96, 96, 96, .8)),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      child:
                          TopGrid(mainGap: 10, perRowCount: 2, itemsCount: 4))),
              Container(
                child: Text('hello'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color.fromRGBO(55, 37, 73, 1),
      ),
      drawer: SideBar(),
    );
  }
}
