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
import 'package:jurham/utils/helper.dart';
import 'package:jurham/utils/kalkulator_saham_brain.dart';

class KalkulatorSahamScreen extends StatefulWidget {
  const KalkulatorSahamScreen({super.key});

  @override
  State<KalkulatorSahamScreen> createState() => _KalkulatorSahamScreenState();
}

class _KalkulatorSahamScreenState extends State<KalkulatorSahamScreen> {
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter.currency(
    name: 'Rp.',
    decimalDigits: 0,
    locale: 'id_ID',
  );

  final _formKey = GlobalKey<FormState>();
  String hargaBeli = '';
  String jumlahLot = '';
  String hargaJual = '';
  bool isFeeCounting = true;
  int dropdownValue = 0;

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
                            "Kalkulator Saham",
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
                                    KalkulatorSahamBrain calc =
                                        KalkulatorSahamBrain(
                                      hargaBeli: unformatCurrency(hargaBeli),
                                      jumlahLot: unformatCurrency(jumlahLot),
                                      hargaJual: unformatCurrency(hargaJual),
                                      isFeeCounting: isFeeCounting,
                                      feeData: feeList.firstWhere((item) =>
                                          item['id'] == dropdownValue),
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
                          ],
                        ),
                      ),
                    ),
                    results.isNotEmpty
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
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
                                  label: 'Total beli :',
                                  value:
                                      formatToCurrency(results["totalBeli"]!),
                                ),
                                SizedBox(
                                  child: Divider(),
                                ),
                                DetailIconRow(
                                  color: Colors.blue,
                                  icon: Icons.monetization_on,
                                  label: 'Total jual :',
                                  value:
                                      formatToCurrency(results["totalJual"]!),
                                ),
                                SizedBox(
                                  child: Divider(),
                                ),
                                DetailIconRow(
                                  color: results["totalProfit"]! > 0
                                      ? Colors.green
                                      : Colors.red,
                                  icon: Icons.receipt_long,
                                  label: 'Total profit :',
                                  value:
                                      formatToCurrency(results["totalProfit"]!),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
      ),
    );
  }
}
