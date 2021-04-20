class CalculateTarget {
  double buy;
  double perc;
  late double sell;
  late double stoploss;
  bool isShort;
  CalculateTarget({this.buy = 0, this.perc = 0, this.isShort = false}) {
    calculate();
  }

  void calculate() {
    double calcSell = ((perc * buy) + 100.063071 * buy) / 99.911929;

    //Risk to Reward ratio of 1:2
    double stoplossAmt = (((perc / 2) * buy) + 100.063071 * buy) / 99.911929;
    if (isShort) {
      sell = buy - (calcSell - buy);
      stoploss = stoplossAmt;
    } else {
      sell = calcSell;
      stoploss = buy - (stoplossAmt - buy);
    }

    // print(sell);
  }
}
