import 'package:flutter/material.dart';
import 'package:jurham/components/jurnal_item.dart';
import 'package:jurham/components/loading.dart';
import 'package:jurham/components/reusable_button.dart';
import 'package:jurham/components/screen_app_bar.dart';
import 'package:jurham/components/tambah_jurnal_bottom_sheet.dart';
import 'package:jurham/components/title_card.dart';
import 'package:jurham/constants.dart';
import 'package:jurham/services/data_services.dart';
import 'package:jurham/utils/helper.dart';
import 'package:jurham/utils/kalkulator_saham_brain.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PilihJurnalScreen extends StatefulWidget {
  const PilihJurnalScreen({super.key});

  @override
  State<PilihJurnalScreen> createState() => _PilihJurnalScreenState();
}

class _PilihJurnalScreenState extends State<PilihJurnalScreen> {
  bool isLoading = true;

  List<dynamic> avgDatas = [];
  List<dynamic> feeDatas = [];

  @override
  void initState() {
    super.initState();
    fetchAPI();
  }

  Future<void> fetchAPI() async {
    final String? token = await getToken();

    if (token != null) {
      List<dynamic> fetchedAvg = await DataServices.getAvgData(token);
      List<dynamic> fetchedFee = await DataServices.fetchFeeList();

      setState(() {
        avgDatas = fetchedAvg[0]['data'];
        feeDatas = fetchedFee;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> submitForm(data) async {
    setState(() {
      isLoading = true;
      avgDatas = [];
    });

    final String? token = await getToken();

    if (token != null) {
      List<dynamic> fetchedAvg = await DataServices.addAvgData(token, data);

      setState(() {
        avgDatas = fetchedAvg[0]['data'];
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteItem(id) async {
    setState(() {
      isLoading = true;
      avgDatas = [];
    });

    final String? token = await getToken();

    if (token != null) {
      List<dynamic> fetchedAvg = await DataServices.deleteAvgData(token, id);

      setState(() {
        avgDatas = fetchedAvg[0]['data'];
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(),
      body: SafeArea(
        child: isLoading
            ? Loading()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                      child: TitleCard(
                        cardChildren: <Widget>[
                          Text(
                            "Pilih Jurnal",
                            style: kTitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: ReusableButton(
                          title: "Tambah Jurnal +",
                          backgroundColor: Color(0xFFD47D19),
                          handlePress: () => showBarModalBottomSheet(
                            context: context,
                            builder: (context) => TambahJurnalBottomSheet(
                              submitForm: submitForm,
                            ),
                          ),
                        ),
                      ),
                    ),
                    avgDatas.isEmpty
                        ? SizedBox(
                            height: 100.0,
                            child: Center(
                              child: Text("Belum ada jurnal."),
                            ),
                          )
                        : Column(
                            children: avgDatas.map<Widget>((item) {
                              final int totalPrice =
                                  item['detail'].fold(0, (sum, detail) {
                                final price = detail['price'] ?? 0;
                                return detail['action_type'] == 'b'
                                    ? sum + price
                                    : sum - price;
                              });

                              final int totalLot =
                                  item['detail'].fold(0, (sum, detail) {
                                final lot = detail['lot'] ?? 0;
                                return detail['action_type'] == 'b'
                                    ? sum + lot
                                    : sum - lot;
                              });

                              KalkulatorSahamBrain calc = KalkulatorSahamBrain(
                                hargaBeli: totalPrice,
                                jumlahLot: totalLot,
                                hargaJual: item['target_sell'],
                                isFeeCounting: item['is_fee_counting'] == 'Y'
                                    ? true
                                    : false,
                                feeData: feeDatas.firstWhere((fee) =>
                                    fee['id'] == item['fee_transaction_id']),
                              );

                              return JurnalItem(
                                id: item['id'],
                                uuid: item['uuid'],
                                label: item['stock_name'],
                                targetSell: formatToCurrency(
                                  item['target_sell'].toDouble(),
                                ),
                                detailPrice: formatToCurrency(
                                  totalPrice.toDouble(),
                                ),
                                detailLot: formatNoCurrency(
                                  totalLot.toDouble(),
                                ),
                                detailLength: item['detail'].length,
                                totalProfit:
                                    calc.getResults()['totalProfit'] ?? 0,
                                onPressed: deleteItem,
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
