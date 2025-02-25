import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jurham/components/delete_dialog.dart';
import 'package:jurham/screens/fitur_pengguna_screens/jurnal_saham_detail_screen.dart';
import 'package:jurham/utils/helper.dart';

class JurnalItem extends StatelessWidget {
  const JurnalItem({
    super.key,
    required this.id,
    required this.uuid,
    required this.label,
    required this.targetSell,
    required this.detailPrice,
    required this.detailLot,
    required this.detailLength,
    required this.totalProfit,
    required this.onPressed,
  });

  final int id;
  final String uuid;
  final String label;
  final String targetSell;
  final String detailPrice;
  final String detailLot;
  final int detailLength;
  final double totalProfit;
  final Function(dynamic) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 5.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JurnalSahamDetailScreen(
                        uuid: uuid,
                      ),
                    ),
                  );
                },
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  deleteDialog(
                    context,
                    id,
                    onPressed,
                  );
                },
                label: Icon(FontAwesomeIcons.trash),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                  iconColor: WidgetStatePropertyAll(Colors.white),
                  iconSize: WidgetStatePropertyAll(15.0),
                  minimumSize: WidgetStatePropertyAll(
                    Size(30.0, 35.0),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              )
            ],
          ),
          Text("AVG = $detailPrice x $detailLot Lot ($detailLength Data)"),
          Text("Target Jual = $targetSell"),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Potensi profit",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    formatToCurrency(totalProfit),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: totalProfit < 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JurnalSahamDetailScreen(
                        uuid: uuid,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(
                    Size(20.0, 35.0),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Text('Lihat'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
