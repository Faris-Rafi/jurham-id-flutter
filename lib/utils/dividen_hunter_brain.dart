class DividenHunterBrain {
  final int hargaDividen;
  final int hargaBeli;
  final int jumlahLot;
  final int hargaJual;
  final bool isFeeCounting;
  final Map<String, dynamic> feeData;

  DividenHunterBrain({
    required this.hargaDividen,
    required this.hargaBeli,
    required this.jumlahLot,
    required this.hargaJual,
    required this.isFeeCounting,
    required this.feeData,
  });

  final Map<String, double> _results = {
    'dividenYield': 0,
    'nominal': 0,
    'earnedDividen': 0,
    'gainOrLoss': 0,
    'potentialProfit': 0,
    'profitPercent': 0,
  };

  Map<String, double> getResults() {
    double totalFeeBuy = 0;
    double totalFeeSell = 0;

    if (isFeeCounting) {
      totalFeeBuy = (feeData['buy'] / 100) * (hargaBeli * (jumlahLot * 100));
      totalFeeSell = (feeData['sell'] / 100) * (hargaJual * (jumlahLot * 100));
    }

    double dividenYield = (hargaDividen / hargaBeli) * 100;
    double nominal = hargaBeli * (jumlahLot * 100);
    int earnedDividen =
        (hargaBeli * (jumlahLot * 100) * (dividenYield / 100)).round();
    double gainOrLoss =
        hargaJual * (jumlahLot * 100) - hargaBeli * (jumlahLot * 100);
    int potentialProfit = (hargaJual * (jumlahLot * 100) -
            totalFeeSell -
            hargaBeli * (jumlahLot * 100) +
            totalFeeBuy +
            hargaBeli * (jumlahLot * 100) * (dividenYield / 100))
        .round();
    double profitPercent = (potentialProfit / nominal) * 100;

    _results['dividenYield'] = dividenYield;
    _results['nominal'] = nominal;
    _results['earnedDividen'] = earnedDividen.toDouble();
    _results['gainOrLoss'] = gainOrLoss;
    _results['potentialProfit'] = potentialProfit.toDouble();
    _results['profitPercent'] = profitPercent;

    return _results;
  }
}
