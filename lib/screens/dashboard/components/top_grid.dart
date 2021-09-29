import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/widgets/dashboard_chip.dart';

class TopGrid extends StatelessWidget {
  final int perRowCount;
  final int itemsCount;
  final double mainGap;
  final crossGap = 20.0;
  final List<DashboardChip> chips;
  TopGrid({
    required this.perRowCount,
    required this.itemsCount,
    required this.mainGap,
    required this.chips,
    crossGap,
  });

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
              mainAxisExtent: 100),
          itemBuilder: (context, index) {
            return Container(
              child: DashboardChip(
                color: chips[index].color,
                title: chips[index].title,
                icon: chips[index].icon,
                summary: chips[index].summary,
              ),
            );
          }),
    );
  }
}
