import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 120.0,
      leading: Container(
        padding: EdgeInsets.all(10.0),
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Color(0xFF0FA588),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8), // Adjust radius as needed
              ),
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                strokeAlign: 1.0,
                color: Color(0xFF0FA588),
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
              ),
              SizedBox(
                width: 3.0,
              ),
              Text(
                "Kembali",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      shape: Border(
        bottom: BorderSide(
          color: Color(0xFFDEE2E6),
        ),
      ),
      actions: [
        Image.asset(
          'images/Jurham.id-right.png',
          height: 125.0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
