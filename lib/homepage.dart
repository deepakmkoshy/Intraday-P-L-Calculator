import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _buyController = TextEditingController();
  final _sellController = TextEditingController();
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
  double totalProfit = 0;

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
    buy = double.parse(_buyController.text);
    sell = double.parse(_sellController.text);
    profit = sell - buy;
    totalAmount = sell + buy;
    brokerage = totalAmount * 0.0005;
    stt = 0.00025 * sell;
    gst = brokerage * 0.18;
    turnoverCharge = 0.0000325 * totalAmount;
    gstTurnover = turnoverCharge * 0.18;
    totalFees = brokerage + stt + gst + turnoverCharge + gstTurnover;
    totalProfit = profit - totalFees;
    totalProfit = double.parse(totalProfit.toStringAsFixed(2));
  }

  void errorCheck() {
    setState(() {
      
    try {
      
        double b = double.parse(_buyController.text);
        _showBuyValidationError = false;}
         on Exception catch (e) {
        print('Error: $e');

        _showBuyValidationError = true;}

        try{double s = double.parse(_sellController.text);
        _showSellValidationError = false;}
        on Exception catch (e) {
        print('Error: $e');

        _showSellValidationError = true;}

    });
    
    
  }

  Widget textField(String label, TextEditingController textEditingController) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        controller: textEditingController,
        decoration: InputDecoration(
          errorText: (label=='Buy Amount')?
          (_showBuyValidationError ? 'Fix errors' : null):
          (_showSellValidationError ? 'Fix errors' : null),
          
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
    // final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Intraday P&L Calculator'),
        centerTitle: true,
        backgroundColor: Color(0XFF0043b4),
      ),
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
              RaisedButton(
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: Color(0XFF0043b4),
                onPressed: () {
                  //Implement null check both input fields
                  print(_buyController.text);
                  errorCheck();
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white, fontSize: width / 25),
                ),
              ),
              Visibility(
                visible: true,
                child: Container(
                  width: 100,
                  height: 30,
                  child: Text('P&L: $totalProfit'),
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
