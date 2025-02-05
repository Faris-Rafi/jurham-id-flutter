import 'package:flutter/material.dart';
import 'package:jurham/components/screen_app_bar.dart';

class AraArbScreen extends StatelessWidget {
  const AraArbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: Text("Hello World!"),
    );
  }
}
