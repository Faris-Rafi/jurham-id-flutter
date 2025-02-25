import 'package:flutter/material.dart';

Future<void> deleteDialog(
  BuildContext context,
  int id,
  Function(dynamic) onPressed,
) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete item"),
          content: Text("Apa anda yakin?"),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Hapus'),
              onPressed: () {
                onPressed(id);
                Navigator.of(context).pop();
              },
            ),
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
      });
}
