import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  final List<Widget> cardChildren;

  const TitleCard({
    super.key,
    required this.cardChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Color(0xFF0FA588),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10.0,
        children: cardChildren,
      ),
    );
  }
}
