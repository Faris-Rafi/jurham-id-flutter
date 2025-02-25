import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  TextForm({
    super.key,
    required this.label,
    required this.handleChange,
    required this.handleValidator,
    required this.obscureText,
    this.initialValue,
    this.maxLines,
  });

  final String label;
  final ValueChanged<String>? handleChange;
  final FormFieldValidator<String>? handleValidator;
  final bool obscureText;
  String? initialValue;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
      ),
      validator: handleValidator,
      onChanged: handleChange,
      initialValue: initialValue,
    );
  }
}
