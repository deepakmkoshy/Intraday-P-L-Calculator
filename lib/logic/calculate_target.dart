class CalculateTarget {
  double buy;
  double perc;
  late double sell;
  bool isShort;
  CalculateTarget({this.buy = 0, this.perc = 0, this.isShort = false}) {
    calculate();
  }

  void calculate() {
    double calcSell = ((perc * buy) + 100.063071 * buy) / 99.911929;
    if (isShort) {
      sell = buy - (calcSell - buy);
    } else {
      sell = calcSell;
    }

    // print(sell);
  }
}
