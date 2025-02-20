import 'package:flutter/material.dart';
import 'package:jurham/components/loading.dart';
import 'package:jurham/components/reusable_button.dart';
import 'package:jurham/components/screen_app_bar.dart';
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
                                  return 'Tolong masukkan E-mail anda.';
                                }

                                return null;
                              },
                              handleChange: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ReusableButton(
                                formKey: _formKey,
                                title: "Masuk",
                                backgroundColor: Color(0xFFD47D19),
                                handlePress: () async {
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
                                          builder: (context) => MyHomeScreen(),
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

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  TextForm({
    super.key,
    required this.label,
    required this.handleChange,
    required this.handleValidator,
    required this.obscureText,
    this.initialValue,
  });

  final String label;
  final ValueChanged<String>? handleChange;
  final FormFieldValidator<String>? handleValidator;
  final bool obscureText;
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: label,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
      ),
      validator: handleValidator,
      onChanged: handleChange,
      initialValue: initialValue,
    );
  }
}
