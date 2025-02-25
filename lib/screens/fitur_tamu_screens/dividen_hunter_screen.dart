import 'package:flutter/material.dart';
import 'package:jurham/components/detail_icon_row.dart';
import 'package:jurham/components/fee_dialog.dart';
import 'package:jurham/components/format_number_form_field.dart';
import 'package:jurham/components/loading.dart';
import 'package:jurham/components/reusable_button.dart';
import 'package:jurham/components/screen_app_bar.dart';
import 'package:jurham/components/title_card.dart';
import 'package:jurham/constants.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:jurham/services/data_services.dart';
import 'package:jurham/utils/dividen_hunter_brain.dart';
import 'package:jurham/utils/helper.dart';

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
  String hargaDividen = '';
  String hargaBeli = '';
  String jumlahLot = '';
  String hargaJual = '';
  bool isFeeCounting = true;
  int dropdownValue = 1;

  Map<String, double> results = {};
  List<dynamic> feeList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> fetchedFeeList = await DataServices.fetchFeeList();
    setState(() {
      feeList = fetchedFeeList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: SafeArea(
        child: feeList.isEmpty
            ? Loading()
            : SingleChildScrollView(
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
                                  hargaDividen = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            FormattedNumberFormField(
                              label: "Harga beli",
                              inputFormatters: [_formatter],
                              handleValidator: priceValidator,
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
                                  jumlahLot = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            FormattedNumberFormField(
                              label: "Harga jual",
                              inputFormatters: [_formatter],
                              handleValidator: priceValidator,
                              handleChange: (value) {
                                setState(() {
                                  hargaJual = value;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isFeeCounting,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isFeeCounting = value!;
                                        });
                                      },
                                    ),
                                    Text("Hitung Fee")
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    feeDialog(
                                      context,
                                      dropdownValue,
                                      (int? value) {
                                        setState(() {
                                          dropdownValue = value!;
                                        });
                                      },
                                      feeList,
                                    );
                                  },
                                  child: Text("Ubah Fee"),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ReusableButton(
                                handlePress: () {
                                  if (_formKey.currentState!.validate()) {
                                    DividenHunterBrain calc =
                                        DividenHunterBrain(
                                      feeData: feeList.firstWhere((item) =>
                                          item['id'] == dropdownValue),
                                      hargaBeli: unformatCurrency(hargaBeli),
                                      hargaDividen:
                                          unformatCurrency(hargaDividen),
                                      hargaJual: unformatCurrency(hargaJual),
                                      isFeeCounting: isFeeCounting,
                                      jumlahLot: unformatCurrency(jumlahLot),
                                    );

                                    setState(() {
                                      results = calc.getResults();
                                    });
                                  }
                                },
                                title: 'Hitung',
                                backgroundColor: Color(0xFFD47D19),
                              ),
                            ),
                            results.isNotEmpty
                                ? Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 15.0,
                                      children: [
                                        DetailIconRow(
                                          color: Colors.grey,
                                          icon: Icons.credit_card,
                                          label: 'Nominal :',
                                          value: formatToCurrency(
                                              results['nominal']!),
                                        ),
                                        SizedBox(
                                          child: Divider(),
                                        ),
                                        DetailIconRow(
                                          color: Colors.green,
                                          icon: Icons.monetization_on,
                                          label: 'Dividen Yield :',
                                          value:
                                              "${formatToCurrency(results['earnedDividen']!)} (${results['dividenYield'].toString()}%)",
                                        ),
                                        SizedBox(
                                          child: Divider(),
                                        ),
                                        DetailIconRow(
                                          color: Colors.red,
                                          icon: Icons.receipt,
                                          label: 'Gain / Loss :',
                                          value: formatToCurrency(
                                              results['gainOrLoss']!),
                                        ),
                                        SizedBox(
                                          child: Divider(),
                                        ),
                                        DetailIconRow(
                                          color: results['potentialProfit']! < 0
                                              ? Colors.red
                                              : Colors.green,
                                          icon: Icons.receipt_long,
                                          label: 'Nett profit :',
                                          value: formatToCurrency(
                                              results['potentialProfit']!),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox.shrink()
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
