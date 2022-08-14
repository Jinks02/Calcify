import 'package:flutter/material.dart';

class CalcButtons extends StatelessWidget {
  final btnColor;
  final btnTextColor;
  final String btnText;
  final buttonTapped;

  const CalcButtons(
      {required this.btnColor,
      required this.btnTextColor,
      required this.btnText,
      required this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            // rounded rectangle
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: btnColor,
              child: Center(
                child: Text(
                  btnText,
                  style: TextStyle(color: btnTextColor, fontSize: 25),
                ),
              ),
            )),
      ),
    );
  }
}
