import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jurham/components/loading.dart';
import 'package:jurham/components/title_card.dart';
import 'package:jurham/components/reusable_icon_button.dart';
import 'package:jurham/constants.dart';
import 'package:jurham/screens/fitur_tamu_screens/ara_arb_screen.dart';
import 'package:jurham/screens/fitur_tamu_screens/dividen_hunter_screen.dart';
import 'package:jurham/screens/fitur_pengguna_screens/pilih_jurnal_screen.dart';
import 'package:jurham/screens/fitur_tamu_screens/kalkulator_saham_screen.dart';
import 'package:jurham/screens/auth_screens/login_screen.dart';
import 'package:jurham/utils/helper.dart';
import 'package:jurham/services/data_services.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  List<dynamic> user = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    authCheck();
  }

  Future<void> authCheck() async {
    final String? token = await getToken();

    if (token != null) {
      List<dynamic> fetchedUser = await DataServices.checkUserData(token);
      setState(() {
        user = fetchedUser;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image.asset(
          'images/Jurham.id.png',
          width: 125.0,
        ),
        shape: Border(
          bottom: BorderSide(
            color: Color(0xFFDEE2E6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (user.isNotEmpty) {
                deleteToken();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );

                setState(() {
                  user = [];
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Color(0xFF0FA588),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Adjust radius as needed
                ),
              ),
              side: WidgetStatePropertyAll(
                BorderSide(
                  strokeAlign: 1.0,
                  color: Color(0xFF0FA588),
                ),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    Text(
                      user.isNotEmpty ? "Keluar" : "Masuk",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Icon(
                      FontAwesomeIcons.arrowRightToBracket,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
      body: isLoading
          ? Loading()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                      child: TitleCard(
                        cardChildren: [
                          SizedBox(
                            child: Text(
                              "Kalkulator dan Jurnal Saham",
                              style: kTitleTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        spacing: 15.0,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Tools & Lainnya",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Wrap(
                            spacing: 5.0,
                            alignment: WrapAlignment.spaceBetween,
                            children: <Widget>[
                              Tooltip(
                                key: tooltipkey,
                                triggerMode: TooltipTriggerMode.manual,
                                message: "Masuk untuk mengakses fitur ini",
                                child: GestureDetector(
                                  onTap: () {
                                    if (user.isEmpty) {
                                      tooltipkey.currentState
                                          ?.ensureTooltipVisible();
                                    }
                                  },
                                  child: ReusableIconButton(
                                    icon: FontAwesomeIcons.bookJournalWhills,
                                    title: "Jurnal Saham",
                                    handlePress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PilihJurnalScreen(),
                                        ),
                                      );
                                    },
                                    isDisabled: user.isNotEmpty ? false : true,
                                  ),
                                ),
                              ),
                              ReusableIconButton(
                                icon: FontAwesomeIcons.calculator,
                                title: "Kalkulator Saham",
                                handlePress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          KalkulatorSahamScreen(),
                                    ),
                                  );
                                },
                                isDisabled: false,
                              ),
                              ReusableIconButton(
                                icon: FontAwesomeIcons.arrowDownUpAcrossLine,
                                title: "ARA ARB",
                                handlePress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AraArbScreen(),
                                    ),
                                  );
                                },
                                isDisabled: false,
                              ),
                              ReusableIconButton(
                                icon: FontAwesomeIcons.divide,
                                title: "Dividen Hunter",
                                handlePress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DividenHunterScreen(),
                                    ),
                                  );
                                },
                                isDisabled: false,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100.0,
                  child: TitleCard(
                    cardChildren: [
                      Column(
                        children: [
                          Text(
                            "© 2025 Kalkulator Saham dan Jurnal Saham,",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "All Right Reserved.",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
