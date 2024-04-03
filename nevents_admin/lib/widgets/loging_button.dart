import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class login_button extends StatelessWidget {
  const login_button({super.key, this.btntext, this.onTap});
  //final Color? btncolor;
  final String? btntext;
  final Widget? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => onTap!,
          ),
        );
      },
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 140, 250, 67),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            //transform: GradientRotation(3.3)
          ),
        ),
        child: Center(
          child: Text(
            btntext!,
            style: const TextStyle(
              color: Color.fromARGB(191, 21, 62, 0),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
