import 'package:flutter/material.dart';
import 'package:jurham/components/detail_icon_row.dart';
import 'package:jurham/components/format_number_form_field.dart';
import 'package:jurham/components/screen_app_bar.dart';
import 'package:jurham/components/title_card.dart';
import 'package:jurham/constants.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class DividenHunterScreen extends StatefulWidget {
  const DividenHunterScreen({super.key});

  @override
  State<DividenHunterScreen> createState() => _DividenHunterScreenState();
}

class _DividenHunterScreenState extends State<DividenHunterScreen> {
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter.currency(
    name: 'Rp.',
    decimalDigits: 0,
    locale: 'id_ID',
  );

  final _formKey = GlobalKey<FormState>();
  String hargaBeli = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100.0,
                child: TitleCard(
                  cardChildren: <Widget>[
                    Text(
                      "Dividen Hunter",
                      style: kTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      FormattedNumberFormField(
                        label: "Harga dividen",
                        inputFormatters: [_formatter],
                        handleValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan harga dividen';
                          }
                          return null;
                        },
                        handleChange: (value) {
                          setState(() {
                            hargaBeli = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FormattedNumberFormField(
                        label: "Harga beli",
                        inputFormatters: [_formatter],
                        handleValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan harga beli';
                          }
                          return null;
                        },
                        handleChange: (value) {
                          setState(() {
                            hargaBeli = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FormattedNumberFormField(
                        label: "Lot",
                        inputFormatters: [
                          CurrencyTextInputFormatter.currency(
                            name: '',
                            decimalDigits: 0,
                          ),
                        ],
                        handleValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan jumlah lot';
                          }
                          return null;
                        },
                        handleChange: (value) {
                          setState(() {
                            hargaBeli = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FormattedNumberFormField(
                        label: "Harga jual",
                        inputFormatters: [_formatter],
                        handleValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong masukkan harga jual';
                          }
                          return null;
                        },
                        handleChange: (value) {
                          setState(() {
                            hargaBeli = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ReusableButton(
                      //     formKey: _formKey,
                      //     hargaBeli: hargaBeli,
                      //     title: 'Hitung',
                      //     backgroundColor: Color(0xFFD47D19),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15.0,
                          children: [
                            DetailIconRow(
                              color: Colors.grey,
                              icon: Icons.credit_card,
                              label: 'Nominal :',
                              value: "Rp.100,000",
                            ),
                            SizedBox(
                              child: Divider(),
                            ),
                            DetailIconRow(
                              color: Colors.green,
                              icon: Icons.monetization_on,
                              label: 'Dividen Yield :',
                              value: "Rp.200,000",
                            ),
                            SizedBox(
                              child: Divider(),
                            ),
                            DetailIconRow(
                              color: Colors.red,
                              icon: Icons.graphic_eq,
                              label: 'Gain / Loss :',
                              value: "Rp.200,000",
                            ),
                            SizedBox(
                              child: Divider(),
                            ),
                            DetailIconRow(
                              color: Colors.green,
                              icon: Icons.receipt_long,
                              label: 'Total profit :',
                              value: "Rp.100,000",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
