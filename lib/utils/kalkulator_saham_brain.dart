class KalkulatorSahamBrain {
  final int hargaBeli;
  final int jumlahLot;
  final int hargaJual;
  final bool isFeeCounting;
  final Map<String, dynamic> feeData;

  KalkulatorSahamBrain({
    required this.hargaBeli,
    required this.jumlahLot,
    required this.hargaJual,
    required this.isFeeCounting,
    required this.feeData,
  });

  final Map<String, double> _results = {
    'totalBeli': 0,
    'totalJual': 0,
    'totalProfit': 0,
  };

  Map<String, double> getResults() {
    double totalFeeBuy = 0;
    double totalFeeSell = 0;

    if (isFeeCounting) {
      totalFeeBuy = (feeData['buy'] / 100) * (hargaBeli * (jumlahLot * 100));
      totalFeeSell = (feeData['sell'] / 100) * (hargaJual * (jumlahLot * 100));
    }

    double totalBeli = hargaBeli * (jumlahLot * 100) + totalFeeBuy;
    double totalJual = hargaJual * (jumlahLot * 100) - totalFeeSell;

    _results['totalBeli'] = totalBeli;
    _results['totalJual'] = totalJual;
    _results['totalProfit'] = totalJual - totalBeli;

    return _results;
  }
}
