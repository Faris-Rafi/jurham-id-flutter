import 'package:flutter/material.dart';
import 'package:jurham/components/screen_app_bar.dart';

class JurnalSahamScreen extends StatelessWidget {
  const JurnalSahamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: Text("Hello World!"),
    );
  }
}
