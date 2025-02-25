import 'package:flutter/material.dart';
import 'package:jurham/components/loading.dart';
import 'package:jurham/components/reusable_button.dart';
import 'package:jurham/components/screen_app_bar.dart';
import 'package:jurham/components/text_form.dart';
import 'package:jurham/constants.dart';
import 'package:jurham/screens/home_screen.dart';
import 'package:jurham/services/data_services.dart';
import 'package:jurham/utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String email = '';
  String password = '';

  List<dynamic> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ScreenAppBar(),
      body: SafeArea(
        child: isLoading
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "MASUK",
                    style: kTitleTextStyleBlack,
                  ),
                  result.isNotEmpty && result[0].containsKey("error")
                      ? Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "${result[0]["error"]}",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextForm(
                              label: "E-mail",
                              obscureText: false,
                              handleValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tolong masukkan E-mail anda.';
                                }

                                return null;
                              },
                              handleChange: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextForm(
                              label: "Password",
                              obscureText: true,
                              handleValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tolong masukkan Password anda.';
                                }

                                return null;
                              },
                              handleChange: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ReusableButton(
                                title: "Masuk",
                                backgroundColor: Color(0xFFD47D19),
                                handlePress: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    List<dynamic> fetchedUser =
                                        await DataServices.loginUser({
                                      "email": email,
                                      "password": password,
                                    });

                                    if (fetchedUser.isNotEmpty &&
                                        fetchedUser[0].containsKey('token')) {
                                      saveToken(fetchedUser[0]['token']);

                                      setState(() {
                                        isLoading = false;
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomeScreen(),
                                          ),
                                          (route) => false,
                                        );
                                      });
                                    } else {
                                      setState(() {
                                        result = fetchedUser;
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
      ),
    );
  }
}
