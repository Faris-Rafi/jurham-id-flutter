import 'package:flutter/material.dart';

class ReusableIconButton extends StatelessWidget {
  const ReusableIconButton({
    super.key,
    required this.icon,
    required this.title,
    required this.handlePress,
    required this.isDisabled,
  });

  final IconData icon;
  final String title;
  final Function handlePress;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 80.0,
        child: Column(
          spacing: 5.0,
          children: <Widget>[
            RawMaterialButton(
              onPressed: !isDisabled
                  ? () {
                      handlePress();
                    }
                  : null,
              fillColor: !isDisabled ? Color(0xFFD47D19) : Colors.grey[300],
              constraints: BoxConstraints.tightFor(
                width: 56.0,
                height: 56.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}
