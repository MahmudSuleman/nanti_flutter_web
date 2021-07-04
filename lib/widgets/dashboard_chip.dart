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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 1,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: color,
      ),
      padding: EdgeInsets.all(20),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          SizedBox(
            height: 20,
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
