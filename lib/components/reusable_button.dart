import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.title,
    required this.backgroundColor,
    required this.handlePress,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final String title;
  final Color backgroundColor;
  final Function handlePress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          handlePress();
        }
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
