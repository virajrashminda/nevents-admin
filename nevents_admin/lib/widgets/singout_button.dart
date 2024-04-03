import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class signoutbutton extends StatelessWidget {
  final Function()? function;

  const signoutbutton({
    super.key,
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
            color: Colors.redAccent,
            border: Border.all(
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          width: 210,
          height: 35,
          child: const Text(
            'SIGN OUT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
