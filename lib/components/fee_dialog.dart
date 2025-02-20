import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

Future<void> feeDialog(
  BuildContext context,
  int dropdownValue,
  ValueChanged<int?>? handleChange,
  List feeList,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Ubah Fee'),
        content: DropdownButtonFormField<int>(
          decoration: InputDecoration(
            labelText: "Pilih fee",
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
          ),
          value: dropdownValue == 0 ? feeList.first['id'] : dropdownValue,
          icon: const Icon(FontAwesomeIcons.chevronDown),
          onChanged: handleChange,
          items: feeList.map((value) {
            return DropdownMenuItem<int>(
              value: value['id'],
              child: Text("Beli ${value['buy']}%, Jual ${value['sell']}%"),
            );
          }).toList(),
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
