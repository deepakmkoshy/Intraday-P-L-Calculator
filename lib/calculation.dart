class Calculation {
  double profit;
  double buy;
  double sell;
  double totalAmount;
  double brokerage;
  double stt;
  double gst;
  double turnoverCharge;
  double gstTurnover;
  double totalFees;
  String profitper;
  double totalProfit = 0;

  Calculation({this.buy, this.sell});
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
    profitper = (totalProfit * 100 / buy).toStringAsFixed(2);
    totalProfit = double.parse(totalProfit.toStringAsFixed(2));
  }
}
