import 'package:flutter/material.dart';
import 'package:intradaypl/components/button.dart';
import 'package:intradaypl/constants/decoration.dart';
import 'package:intradaypl/logic/calculate_target.dart';

class Target extends StatefulWidget {
  @override
  _TargetState createState() => _TargetState();
}

class _TargetState extends State<Target> with AutomaticKeepAliveClientMixin {
  final _priceController = TextEditingController();
  final _percentageController = TextEditingController();
  bool _showPriceValidationError = false;
  bool _showPercValidationError = false;

  bool _isCalActive = false;

  double _sell = 0;

  void calculate() {
    double price = double.parse(_priceController.text);
    double perc = double.parse(_percentageController.text);
    final calcTarget = CalculateTarget(buy: price, perc: perc);
    _sell = calcTarget.sell;
    _isCalActive = true;
  }

  void _errorCheck() {
    setState(() {
      try {
        double.parse(_priceController.text);
        _showPriceValidationError = false;
        _isCalActive = false;
      } on Exception catch (e) {
        print('Error: $e');

        _showPriceValidationError = true;
      }

      try {
        double.parse(_percentageController.text);
        _showPercValidationError = false;
        _isCalActive = false;
      } on Exception catch (e) {
        print('Error: $e');

        _showPercValidationError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                        decoration: InputDecoration(
                          prefixText: '₹',
                          errorText:
                              _showPriceValidationError ? 'Fix errors' : null,
                          labelText: 'Buy Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _percentageController,
                        decoration: InputDecoration(
                          suffixText: '%',
                          errorText:
                              _showPercValidationError ? 'Fix errors' : null,
                          labelText: 'Expected Profit % ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Button(
                  onPressed: () {
                    //Implement null check both input fields
                    _errorCheck();
                    if (!(_showPriceValidationError ||
                        _showPriceValidationError)) {
                      calculate();
                    }
                  },
                  width: width,
                  height: height),
              SizedBox(
                height: height * 0.03,
              ),
              Visibility(
                visible: _isCalActive,
                child: Container(
                    width: width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Sell Amount: '),
                          Text(
                            _sell.toStringAsFixed(2),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    decoration: cardBoxDecoration),
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
