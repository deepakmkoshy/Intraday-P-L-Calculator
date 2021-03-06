import 'package:flutter/material.dart';
import 'package:intradaypl/calculation.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController _tabController;

  final _buyController = TextEditingController();
  final _sellController = TextEditingController();
  late double width;
  late double height;
  late Calculation calculation = Calculation(buy: 0, sell: 0);
  bool isCalActive = false;
  bool _showBuyValidationError = false;
  bool _showSellValidationError = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _buyController.dispose();
    _sellController.dispose();
    super.dispose();
  }

  void calculate() {
    double sell = double.parse(_sellController.text);
    double buy = double.parse(_buyController.text);
    calculation = Calculation(buy: buy, sell: sell);
    calculation.calculate();
    isCalActive = true;
  }

  void errorCheck() {
    setState(() {
      try {
        double.parse(_buyController.text);
        _showBuyValidationError = false;
        isCalActive = false;
      } on Exception catch (e) {
        print('Error: $e');

        _showBuyValidationError = true;
      }

      try {
        double.parse(_sellController.text);
        _showSellValidationError = false;
        isCalActive = false;
      } on Exception catch (e) {
        print('Error: $e');

        _showSellValidationError = true;
      }
    });
  }

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: width / 20,
          fontWeight: FontWeight.bold,
          color: (calculation.totalProfit < 0) ? Colors.red : Colors.green),
    );
  }

  Widget textField(String label, TextEditingController textEditingController) {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: textEditingController,
        decoration: InputDecoration(
          prefixText: '₹',
          errorText: (label == 'Buy Amount')
              ? (_showBuyValidationError ? 'Fix errors' : null)
              : (_showSellValidationError ? 'Fix errors' : null),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('Intraday P&L Calculator'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                // icon: Icon(Icons.calculate_outlined),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calculate_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Percentage')
                  ],
                ),
                // text: 'Percentage',
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timeline_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Target')
                  ],
                ),
                // text: 'Target',
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Color(0XFF0043b4),
        ),
        backgroundColor: Colors.grey[100],

        //Wrapping with gesture detector to hide keyboard
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                /*This method here will hide the soft keyboard.*/
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            textField('Buy Amount', _buyController),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            textField('Sell Amount', _sellController),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          primary: Color(0XFF0043b4),
                        ),
                        onPressed: () {
                          //Implement null check both input fields
                          print(_buyController.text);
                          errorCheck();
                          if (!(_showSellValidationError ||
                              _showBuyValidationError)) {
                            calculate();
                          }
                        },
                        child: Text(
                          'Calculate',
                          style: TextStyle(
                              color: Colors.white, fontSize: width / 25),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Visibility(
                        visible: isCalActive,
                        child: Container(
                          width: width * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                text('P&L: ₹${calculation.totalProfit}'),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                text('${calculation.profitper}%'),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x40000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 0))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text("New"),
              ),
            )
          ],
        ));
  }
}
