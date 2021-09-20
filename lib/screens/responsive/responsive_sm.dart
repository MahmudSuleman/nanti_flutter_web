import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/screens/dashboard/components/side_bar.dart';
import 'package:nanti_flutter_web/screens/dashboard/components/top_grid.dart';

import '../../constants.dart';

class ResponsiveSm extends StatelessWidget {
  const ResponsiveSm({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
                    child:
                        TopGrid(mainGap: 10, perRowCount: 1, itemsCount: 4))),
            Container(
              child: Text('hello'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: kAppBarBackground,
      ),
      drawer: Drawer(
        child: Container(
          color: kAppBarBackground,
          child: SideBar(),
        ),
      ),
    );
  }
}
