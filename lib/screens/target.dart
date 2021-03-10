import 'package:flutter/material.dart';
import 'package:intradaypl/calculate_target.dart';

class Target extends StatefulWidget {
  @override
  _TargetState createState() => _TargetState();
}

class _TargetState extends State<Target> with AutomaticKeepAliveClientMixin {
  final _priceController = TextEditingController();
  final _percentageController = TextEditingController();
  bool _showPriceValidationError = false;
  bool _showPercValidationError = false;
  late double width;
  late double height;
  bool isCalActive = false;
 
  double sell = 0;

void calculate() {
    double price = double.parse(_priceController.text);
    double perc = double.parse(_percentageController.text);
    var calcTarget = CalculateTarget();
    // var calcTarget = CalculateTarget(buy: price, perc: perc);
    // calculation.calculate();
    isCalActive = true;
  }

  Widget textField(String label, TextEditingController textEditingController) {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: textEditingController,
        decoration: InputDecoration(
          prefixText: '₹',
          errorText: (label == 'Buy Amount')
          ? (_showPriceValidationError ? 'Fix errors' : null)
          : (_showPercValidationError ? 'Fix errors' : null),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  void errorCheck() {
    setState(() {
      try {
        double.parse(_priceController.text);
        _showPriceValidationError = false;
        isCalActive = false;
      } on Exception catch (e) {
        print('Error: $e');

        _showPriceValidationError = true;
      }

      try {
        double.parse(_percentageController.text);
        _showPercValidationError = false;
        isCalActive = false;
      } on Exception catch (e) {
        print('Error: $e');

        _showPercValidationError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return GestureDetector(
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
                    textField('Buy Amount', _priceController),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    textField('Expected Percentage', _percentageController),
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
                  errorCheck();
                  if (!(_showPriceValidationError || _showPriceValidationError)) {
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
                  width: width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                       Text('Sell Amount: '),
                       Text('b'),
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

  @override
  bool get wantKeepAlive => true;
}
