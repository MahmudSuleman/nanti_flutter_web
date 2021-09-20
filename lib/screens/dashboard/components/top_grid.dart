import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/widgets/dashboard_chip.dart';

class TopGrid extends StatelessWidget {
  final int perRowCount;
  final int itemsCount;
  final double mainGap;
  final crossGap = 20.0;
  // final List<DashboardChip> chips;
  TopGrid(
      {required this.perRowCount,
      required this.itemsCount,
      required this.mainGap,
      crossGap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      child: GridView.builder(
        itemCount: itemsCount,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: perRowCount,
            crossAxisSpacing: crossGap,
            mainAxisSpacing: mainGap,
            mainAxisExtent: 150),
        itemBuilder: (context, index) => Container(
          child: DashboardChip(
            color: Colors.yellow,
            title: 'Devices',
            icon: Icons.phone_android,
            summary: '200',
          ),
        ),
      ),
    );
  }
}
