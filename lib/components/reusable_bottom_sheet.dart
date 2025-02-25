import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableBottomSheet extends StatelessWidget {
  const ReusableBottomSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Container(),
          middle: Text('Modal Page'),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
