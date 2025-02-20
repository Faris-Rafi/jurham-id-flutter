import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:money_formatter/money_formatter.dart';

final storage = FlutterSecureStorage();

int unformatCurrency(String? formattedValue) {
  if (formattedValue == null || formattedValue.isEmpty) return 0;
  String cleaned = formattedValue.replaceAll(RegExp(r'[^0-9]'), '');
  return int.parse(cleaned);
}

String formatToCurrency(double value) {
  if (value == 0) return '';
  MoneyFormatter fmf = MoneyFormatter(
    amount: value,
    settings: MoneyFormatterSettings(symbol: "Rp.", fractionDigits: 0),
  );
  return fmf.output.symbolOnLeft;
}

int roundFloorPrice(double price) {
  if (price < 200) {
    return price.floor();
  } else if (price < 500) {
    return (price / 2).floor() * 2;
  } else if (price < 2000) {
    return (price / 5).floor() * 5;
  } else if (price < 5000) {
    return (price / 10).floor() * 10;
  } else {
    return (price / 25).floor() * 25;
  }
}

int roundCeilPrice(double price) {
  if (price < 200) {
    return price.ceil();
  } else if (price < 500) {
    return (price / 2).ceil() * 2;
  } else if (price < 2000) {
    return (price / 5).ceil() * 5;
  } else if (price < 5000) {
    return (price / 10).ceil() * 10;
  } else {
    return (price / 25).ceil() * 25;
  }
}

String? priceValidator(String? value) {
  int inputtedValue = unformatCurrency(value);
  String formattedFloorValue =
      formatToCurrency(roundFloorPrice(inputtedValue.toDouble()).toDouble());
  String formattedCeilValue =
      formatToCurrency(roundCeilPrice(inputtedValue.toDouble()).toDouble());

  if (value == null || value.isEmpty) {
    return 'Tolong masukkan jumlah yang valid.';
  } else if (inputtedValue < 50) {
    return 'Harga tidak boleh kurang dari Rp.50';
  } else if (inputtedValue > 200000) {
    return 'Harga tidak boleh lebih dari Rp.200.000';
  } else {
    if (inputtedValue != roundFloorPrice(inputtedValue.toDouble())) {
      return "Harga tidak tersedia, pakai $formattedFloorValue atau $formattedCeilValue";
    }
  }
  return null;
}

int setAraArbPercentage(hargaPenutupan, percent) {
  if (hargaPenutupan >= 200 && hargaPenutupan <= 5000) {
    return percent - 10 <= 0 ? percent : percent - 10;
  } else if (hargaPenutupan > 5000) {
    return percent - 15 <= 0 ? percent : percent - 10;
  } else {
    return percent;
  }
}

double calculateRoundedMaxY(maxY) {
  if (maxY <= 0) return 0;

  int magnitude = pow(10, (log(maxY) / log(10)).floor()).toInt();

  double roundingFactor = magnitude * 2;

  return ((((maxY / roundingFactor) * 10).ceil() / 10) * roundingFactor)
      .toDouble();
}

Future<void> saveToken(String token) async {
  await storage.write(key: "auth_token", value: token);
}

Future<String?> getToken() async {
  return await storage.read(key: "auth_token");
}

Future<void> deleteToken() async {
  await storage.delete(key: "auth_token");
}
