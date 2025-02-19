import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FormattedNumberFormField extends StatelessWidget {
  final String label;
  final FormFieldValidator<String> handleValidator;
  final ValueChanged<String> handleChange;
  final List<TextInputFormatter>? inputFormatters;
  String? initialValue;

  FormattedNumberFormField({
    super.key,
    required this.label,
    required this.handleValidator,
    required this.handleChange,
    required this.inputFormatters,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters,
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
