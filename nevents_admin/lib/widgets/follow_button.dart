import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class followbutton extends StatelessWidget {
  final Function()? function;
  final backgroundcolor;
  final Color bordercolor;
  final String text;
  final Color textcolor;
  const followbutton({
    super.key,
    required this.backgroundcolor,
    required this.bordercolor,
    required this.text,
    required this.textcolor,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundcolor,
            border: Border.all(
              color: bordercolor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 210,
          height: 35,
        ),
      ),
    );
  }
}
