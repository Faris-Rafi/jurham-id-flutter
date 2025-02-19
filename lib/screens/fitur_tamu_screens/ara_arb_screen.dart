import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jurham/components/ara_arb_chart.dart';
import 'package:jurham/components/ara_arb_detail_icon_row.dart';
import 'package:jurham/components/ara_arb_option_dialog.dart';
import 'package:jurham/components/format_number_form_field.dart';
import 'package:jurham/components/loading.dart';
import 'package:jurham/components/reusable_button.dart';
import 'package:jurham/components/screen_app_bar.dart';
import 'package:jurham/components/title_card.dart';
import 'package:jurham/constants.dart';
import 'package:jurham/services/data_services.dart';
import 'package:jurham/utils/ara_arb_brain.dart';
import 'package:jurham/utils/helper.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AraArbScreen extends StatefulWidget {
  const AraArbScreen({super.key});

  @override
  State<AraArbScreen> createState() => _AraArbScreenState();
}

class _AraArbScreenState extends State<AraArbScreen> {
  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter.currency(
    name: 'Rp.',
    decimalDigits: 0,
    locale: 'id_ID',
  );
  final _formKey = GlobalKey<FormState>();

  String hargaPenutupan = "";
  int dropdownValue = 1;

  Map<String, int> araArbOpts = {
    'ara': 2,
    'arb': 5,
  };

  List<dynamic> rules = [];
  Map<String, dynamic> results = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> fetchedRules = await DataServices.araArbRules();
    setState(() {
      rules = fetchedRules;
    });
  }

  void handleJumlahAra(value) {
    setState(() {
      araArbOpts['ara'] = value.isNotEmpty ? int.parse(value) : 0;
    });
  }

  void handleJumlahArb(value) {
    setState(() {
      araArbOpts['arb'] = value.isNotEmpty ? int.parse(value) : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: SafeArea(
        child: rules.isEmpty
            ? Loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                      child: TitleCard(
                        cardChildren: <Widget>[
                          Text(
                            "Kalkulator ARA ARB",
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
                          children: [
                            FormattedNumberFormField(
                              label: "Harga penutupan",
                              inputFormatters: [_formatter],
                              handleValidator: priceValidator,
                              handleChange: (value) {
                                setState(() {
                                  hargaPenutupan = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  labelText: "Pilih peraturan",
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
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 14.0),
                                ),
                                value: rules.first['id'],
                                icon: const Icon(FontAwesomeIcons.chevronDown),
                                onChanged: (int? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: rules.map((value) {
                                  return DropdownMenuItem<int>(
                                    value: value['id'],
                                    child: Text(value['name']),
                                  );
                                }).toList()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    araArbOption(
                                      context,
                                      araArbOpts,
                                      handleJumlahAra,
                                      handleJumlahArb,
                                    );
                                  },
                                  child: Text("Pengaturan ARA/ARB"),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ReusableButton(
                                formKey: _formKey,
                                handlePress: () {
                                  AraArbBrain calc = AraArbBrain(
                                    hargaPenutupan:
                                        unformatCurrency(hargaPenutupan),
                                    rules: rules.firstWhere(
                                        (item) => item['id'] == dropdownValue),
                                    ara: araArbOpts['ara']!,
                                    arb: araArbOpts['arb']!,
                                  );

                                  setState(() {
                                    results = calc.getResults();
                                  });
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
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "ARA ARB Chart",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 300,
                                padding:
                                    EdgeInsets.only(right: 30.0, left: 10.0),
                                child: AraArbChart(
                                  results: results,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Column(
                                children: results['araValues']
                                        .reversed
                                        .map<Widget>((item) {
                                      return AraArbDetailIconRow(
                                        title: "Harga ARA",
                                        value: formatToCurrency(
                                          item['ara'].toDouble(),
                                        ),
                                        color: Colors.green,
                                        rightSideTitle: "Kenaikan",
                                        percentage: "${item['percent']}%",
                                        icon: Icons.trending_up_sharp,
                                      );
                                    }).toList() ??
                                    [],
                              ),
                              AraArbDetailIconRow(
                                title: "Harga Penutupan",
                                value: formatToCurrency(
                                  results['hargaPenutupan'].toDouble(),
                                ),
                                color: Colors.grey,
                                rightSideTitle: "",
                                percentage: "",
                                icon: Icons.monetization_on,
                              ),
                              Column(
                                children:
                                    results['arbValues'].map<Widget>((item) {
                                          return AraArbDetailIconRow(
                                            title: "Harga ARB",
                                            value: formatToCurrency(
                                              item['arb'].toDouble(),
                                            ),
                                            color: Colors.red,
                                            rightSideTitle: "Turun",
                                            percentage: "${item['percent']}%",
                                            icon: Icons.trending_down_sharp,
                                          );
                                        }).toList() ??
                                        [],
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                            ],
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
      ),
    );
  }
}
