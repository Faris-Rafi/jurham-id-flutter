import 'package:flutter/material.dart';
import 'package:jurham/components/format_number_form_field.dart';

Future<void> araArbOption(
  BuildContext context,
  Map<String, int> araArbOpts,
  ValueChanged<String> handleJumlahAra,
  ValueChanged<String> handleJumlahArb,
) {
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tolong masukkan jumlah yang valid.';
    }

    if (int.parse(value) < 1) {
      return 'Jumlah minimal 1';
    }

    if (int.parse(value) > 10) {
      return 'Jumlah maksimal 10';
    }
    return null;
  }

  return showDialog<void>(
    context: context,
    builder: (
      BuildContext context,
    ) {
      return AlertDialog(
        title: const Text('Pengaturan ARA/ARB'),
        content: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormattedNumberFormField(
                  label: "Jumlah ARA",
                  inputFormatters: [],
                  handleValidator: validator,
                  handleChange: handleJumlahAra,
                  initialValue: araArbOpts['ara'].toString(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FormattedNumberFormField(
                  label: "Jumlah ARB",
                  inputFormatters: [],
                  handleValidator: validator,
                  handleChange: handleJumlahArb,
                  initialValue: araArbOpts['arb'].toString(),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge),
            child: const Text('Tutup'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
