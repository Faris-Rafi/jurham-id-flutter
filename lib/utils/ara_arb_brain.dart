import 'package:jurham/utils/helper.dart';

class AraArbBrain {
  final int hargaPenutupan;
  final Map<String, dynamic> rules;
  final int ara;
  final int arb;

  AraArbBrain({
    required this.hargaPenutupan,
    required this.rules,
    required this.ara,
    required this.arb,
  });

  Map<String, dynamic> getResults() {
    int minPrice = rules['is_below_fifty'] == true ? 10 : 50;

    List<Map<String, dynamic>> araValues = [];
    List<Map<String, dynamic>> arbValues = [];

    int araPercentage = setAraArbPercentage(
      hargaPenutupan,
      rules['ara_percentage'],
    );

    int arbPercentage = rules['arb_percentage'] == 35
        ? setAraArbPercentage(
            hargaPenutupan,
            rules['arb_percentage'],
          )
        : rules['arb_percentage'];

    int araCalc = roundFloorPrice(
      (hargaPenutupan * (100 + araPercentage)) ~/ 100,
    );

    int arbCalc = roundCeilPrice(
      (hargaPenutupan * (100 - arbPercentage)) ~/ 100,
    );

    double araPercentCalc = ((araCalc - hargaPenutupan) / hargaPenutupan) * 100;
    double arbPercentCalc = ((hargaPenutupan - arbCalc) / hargaPenutupan) * 100;

    if (araCalc >= 200000 || arbCalc <= minPrice) {
      if (arbCalc <= minPrice) {
        araValues.insert(0, {
          "no": 1,
          "ara": araCalc,
          "percent": araPercentCalc % 1 == 0
              ? araPercentCalc.toInt().toString()
              : araPercentCalc.toStringAsFixed(2)
        });

        for (int i = 1; i < ara; i++) {
          int oldAraVal = i == 1 ? araCalc : araValues[i - 1]['ara']!;

          int newAraPercentage = setAraArbPercentage(
            oldAraVal,
            rules['ara_percentage'],
          );

          int newAraVal =
              roundFloorPrice((oldAraVal * (100 + newAraPercentage)) ~/ 100);
          araPercentCalc = ((newAraVal - oldAraVal) / oldAraVal) * 100;

          if (newAraVal <= 200000) {
            araValues.insert(i, {
              "no": i,
              "ara": newAraVal,
              "percent": araPercentCalc % 1 == 0
                  ? araPercentCalc.toInt().toString()
                  : araPercentCalc.toStringAsFixed(2)
            });
          }
        }
      }

      if (araCalc >= 200000) {
        arbValues.insert(0, {
          "no": 1,
          "arb": arbCalc,
          "percent": arbPercentCalc % 1 == 0
              ? arbPercentCalc.toInt().toString()
              : arbPercentCalc.toStringAsFixed(2)
        });

        for (int i = 1; i < arb; i++) {
          int oldArbVal = i == 1 ? arbCalc : arbValues[i - 1]['arb']!;

          int newArbPercentage = rules['arb_percentage'] == 35
              ? setAraArbPercentage(
                  oldArbVal,
                  rules['arb_percentage'],
                )
              : rules['arb_percentage'];

          int newArbVal = roundCeilPrice(
            (oldArbVal * (100 - newArbPercentage)) ~/ 100,
          );

          if (newArbVal > minPrice) {
            arbPercentCalc = ((oldArbVal - newArbVal) / oldArbVal) * 100;

            arbValues.insert(i, {
              "no": i + 1,
              "arb": newArbVal,
              "percent": arbPercentCalc % 1 == 0
                  ? arbPercentCalc.toInt().toString()
                  : arbPercentCalc.toStringAsFixed(2)
            });
          } else {
            newArbVal = minPrice;
            arbPercentCalc = ((oldArbVal - newArbVal) / oldArbVal) * 100;

            arbValues.insert(i, {
              "no": i,
              "arb": newArbVal,
              "percent": arbPercentCalc % 1 == 0
                  ? arbPercentCalc.toInt().toString()
                  : arbPercentCalc.toStringAsFixed(2)
            });

            break;
          }
        }
      }

      return {
        "araValues": araValues,
        "arbValues": arbValues,
        "hargaPenutupan": hargaPenutupan,
      };
    } else {
      araValues.insert(0, {
        "no": 1,
        "ara": araCalc,
        "percent": araPercentCalc % 1 == 0
            ? araPercentCalc.toInt().toString()
            : araPercentCalc.toStringAsFixed(2)
      });

      for (int i = 1; i < ara; i++) {
        int oldAraVal = i == 1 ? araCalc : araValues[i - 1]['ara']!;

        int newAraPercentage = setAraArbPercentage(
          oldAraVal,
          rules['ara_percentage'],
        );

        int newAraVal =
            roundFloorPrice((oldAraVal * (100 + newAraPercentage)) ~/ 100);
        araPercentCalc = ((newAraVal - oldAraVal) / oldAraVal) * 100;

        if (newAraVal <= 200000) {
          araValues.insert(i, {
            "no": i + 1,
            "ara": newAraVal,
            "percent": araPercentCalc % 1 == 0
                ? araPercentCalc.toInt().toString()
                : araPercentCalc.toStringAsFixed(2)
          });
        }
      }

      arbValues.insert(0, {
        "no": 1,
        "arb": arbCalc,
        "percent": arbPercentCalc % 1 == 0
            ? arbPercentCalc.toInt().toString()
            : arbPercentCalc.toStringAsFixed(2)
      });

      for (int i = 1; i < arb; i++) {
        int oldArbVal = i == 1 ? arbCalc : arbValues[i - 1]['arb']!;

        int newArbPercentage = rules['arb_percentage'] == 35
            ? setAraArbPercentage(
                oldArbVal,
                rules['arb_percentage'],
              )
            : rules['arb_percentage'];

        int newArbVal = roundCeilPrice(
          (oldArbVal * (100 - newArbPercentage)) ~/ 100,
        );

        if (newArbVal > minPrice) {
          arbPercentCalc = ((oldArbVal - newArbVal) / oldArbVal) * 100;

          arbValues.insert(i, {
            "no": i + 1,
            "arb": newArbVal,
            "percent": arbPercentCalc % 1 == 0
                ? arbPercentCalc.toInt().toString()
                : arbPercentCalc.toStringAsFixed(2)
          });
        } else {
          newArbVal = minPrice;
          arbPercentCalc = ((oldArbVal - newArbVal) / oldArbVal) * 100;

          arbValues.insert(i, {
            "no": i + 1,
            "arb": newArbVal,
            "percent": arbPercentCalc % 1 == 0
                ? arbPercentCalc.toInt().toString()
                : arbPercentCalc.toStringAsFixed(2)
          });

          break;
        }
      }

      return {
        "araValues": araValues,
        "arbValues": arbValues,
        "hargaPenutupan": hargaPenutupan,
      };
    }
  }
}
