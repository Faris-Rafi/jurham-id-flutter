import 'package:flutter/material.dart';
import 'package:jurham/components/screen_app_bar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: Text("Hello World!"),
    );
  }
}
