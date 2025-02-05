import 'package:flutter/material.dart';

class ReusableIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function handlePress;

  const ReusableIconButton({
    super.key,
    required this.icon,
    required this.title,
    required this.handlePress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      child: Column(
        spacing: 5.0,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              handlePress();
            },
            constraints: BoxConstraints.tightFor(
              width: 56.0,
              height: 56.0,
            ),
            fillColor: Color(0xFFD47D19),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Adjust radius as needed
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
