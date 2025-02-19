import 'package:flutter/material.dart';

class AraArbDetailIconRow extends StatelessWidget {
  const AraArbDetailIconRow({
    super.key,
    required this.title,
    required this.value,
    required this.rightSideTitle,
    required this.percentage,
    required this.color,
    required this.icon,
  });

  final String title;
  final String value;
  final String rightSideTitle;
  final String percentage;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      Text(value),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text(rightSideTitle),
                  Text(percentage),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
