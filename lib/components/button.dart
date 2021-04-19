import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function() onPressed;
  final double width;
  final double height;
  Button({required this.onPressed, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        primary: Color(0XFF0043b4),
      ),
      onPressed: onPressed,
      child: Text(
        'Calculate',
        style: TextStyle(
            color: Colors.white,
            fontSize: width > 700 ? height / 20 : width / 20),
      ),
    );
  }
}
