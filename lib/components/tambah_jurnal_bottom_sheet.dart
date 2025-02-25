import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:jurham/components/format_number_form_field.dart';
import 'package:jurham/components/reusable_bottom_sheet.dart';
import 'package:jurham/components/reusable_button.dart';
import 'package:jurham/components/text_form.dart';
import 'package:jurham/constants.dart';
import 'package:jurham/utils/helper.dart';

class TambahJurnalBottomSheet extends StatefulWidget {
  const TambahJurnalBottomSheet({super.key, required this.submitForm});

  final Function(dynamic) submitForm;

  @override
  State<TambahJurnalBottomSheet> createState() =>
      _TambahJurnalBottomSheetState();
}

class _TambahJurnalBottomSheetState extends State<TambahJurnalBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    'stock_name': '',
    'capital_limit': '0',
    'desc': '',
    'fee_transaction_id': "1",
  };

  @override
  Widget build(BuildContext context) {
    return ReusableBottomSheet(
      child: Column(
        children: [
          Text(
            "Tambah Jurnal",
            style: kTitleTextStyleBlack,
          ),
          SizedBox(
            height: 20.0,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextForm(
                  label: "Nama Saham",
                  obscureText: false,
                  handleValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong masukan nama saham.';
                    }

                    return null;
                  },
                  handleChange: (value) => formData['stock_name'] = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                FormattedNumberFormField(
                  label: "Modal",
                  handleValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong masukan modal.';
                    }

                    return null;
                  },
                  handleChange: (value) {
                    String unformatted = unformatCurrency(value).toString();
                    formData['capital_limit'] = unformatted;
                  },
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                      name: '',
                      decimalDigits: 0,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "*Ketik 0 untuk modal tidak terbatas.",
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextForm(
                  label: "Deskripsi (opsional)",
                  obscureText: false,
                  handleValidator: (value) => null,
                  handleChange: (value) => formData['desc'] = value,
                  maxLines: 4,
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ReusableButton(
                    title: "Tambah",
                    backgroundColor: Color(0xFFD47D19),
                    handlePress: () {
                      if (_formKey.currentState!.validate()) {
                        widget.submitForm(formData);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
