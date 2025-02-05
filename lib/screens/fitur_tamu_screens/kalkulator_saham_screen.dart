import 'package:flutter/material.dart';
import 'package:jurham/components/screen_app_bar.dart';

class KalkulatorSahamScreen extends StatelessWidget {
  const KalkulatorSahamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: Text("Hello World!"),
    );
  }
}
