import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';

import '../../constants.dart';
import 'components/side_bar.dart';
import 'components/top_grid.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Container(
        height: 1000,
        child: TopGrid(
          itemsCount: 4,
          perRowCount: 2,
          mainGap: 50,
        ),
      ),
    );
  }
}

class DashboardLargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(55, 37, 73, 1),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SideBar(),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Container(
                  height: 1000,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(96, 96, 96, .8)),
                  child: TopGrid(
                    itemsCount: 4,
                    perRowCount: 4,
                    mainGap: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
