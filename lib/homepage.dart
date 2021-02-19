import 'package:flutter/material.dart';
import 'package:intradaypl/calculation.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _buyController = TextEditingController();
  final _sellController = TextEditingController();
  Calculation calculation = Calculation();
  bool isCalActive = false;
  bool _showBuyValidationError = false;
  bool _showSellValidationError = false;

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
      } on Exception catch (e) {
        print('Error: $e');

        _showBuyValidationError = true;
      }

      try {
        double.parse(_sellController.text);
        _showSellValidationError = false;
      } on Exception catch (e) {
        print('Error: $e');

        _showSellValidationError = true;
      }
    });
  }

  Widget textField(String label, TextEditingController textEditingController) {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: textEditingController,
        decoration: InputDecoration(
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Intraday P&L Calculator'),
        centerTitle: true,
        backgroundColor: Color(0XFF0043b4),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
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
                  if (!(_showSellValidationError || _showBuyValidationError)) {
                    calculate();
                  }
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white, fontSize: width / 25),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Visibility(
                visible: isCalActive,
                child: Container(
                  width: width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'P&L:\n ${calculation.totalProfit}',
                          style: TextStyle(
                              fontSize: width / 20,
                              fontWeight: FontWeight.bold,
                              color: (calculation.totalProfit < 0)
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        Text(
                          '${calculation.profitper}%',
                          style: TextStyle(
                            fontSize: width / 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
    );
  }
}
