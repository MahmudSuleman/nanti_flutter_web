import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';

class DashboardChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final String summary;
  final Color color;

  const DashboardChip(
      {Key? key,
      required this.title,
      required this.icon,
      required this.summary,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: color,
      ),
      padding: EdgeInsets.all(5),
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kCalculateFont(size),
                    color: Colors.white),
              ),
            ),
            FittedBox(
              fit: BoxFit.fill,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Icon(icon,
                        size: kCalculateFont(size), color: Colors.white),
                  ),
                  SizedBox(width: 30),
                  Container(
                    child: Text(
                      summary,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: kCalculateFont(size),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
