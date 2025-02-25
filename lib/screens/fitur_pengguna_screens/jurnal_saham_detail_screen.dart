import 'package:flutter/material.dart';
import 'package:jurham/components/screen_app_bar.dart';

class JurnalSahamDetailScreen extends StatelessWidget {
  const JurnalSahamDetailScreen({super.key, required this.uuid});

  final String uuid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: Text("Hello World!"),
    );
  }
}
