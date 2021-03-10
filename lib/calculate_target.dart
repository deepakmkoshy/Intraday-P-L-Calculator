class CalculateTarget {
  double buy;
  double perc;
  late double sell;
  CalculateTarget({this.buy = 0, this.perc = 0});

  void calculate() {
    sell = ((perc * buy) + 100.063071 * buy) / 99.911929;

    print(sell);
  }
}
