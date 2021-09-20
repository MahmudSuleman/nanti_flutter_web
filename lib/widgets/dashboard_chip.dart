import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: color,
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Icon(icon, size: 50, color: Colors.white),
              ),
              Container(
                child: Text(
                  summary,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
