class Calculation {
  late double profit;
  double buy;
  double sell;
  late double totalAmount;
  late double brokerage;
  late double stt;
  late double gst;
  late double turnoverCharge;
  late double gstTurnover;
  late double totalFees;
  String profitper = '';
  double totalProfit = 0;

  Calculation({required this.buy, required this.sell});
  void calculate() {
    profit = sell - buy;
    totalAmount = sell + buy;
    brokerage = totalAmount * 0.0005;
    stt = 0.00025 * sell;
    gst = brokerage * 0.18;
    turnoverCharge = 0.0000345 * totalAmount;
    gstTurnover = turnoverCharge * 0.18;
    totalFees = brokerage + stt + gst + turnoverCharge + gstTurnover;
    totalProfit = profit - totalFees;
    print(totalProfit);
    profitper = (totalProfit * 100 / buy).toStringAsFixed(2);
    totalProfit = double.parse(totalProfit.toStringAsFixed(2));
  }
}
