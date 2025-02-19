import 'package:flutter/material.dart';

class DetailIconRow extends StatelessWidget {
  const DetailIconRow({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
    required this.value,
  });

  final Color color;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
