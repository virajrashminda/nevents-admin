import 'package:flutter/material.dart';

class welcomescafold extends StatelessWidget {
  const welcomescafold({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          //Image.asset(//'assets/images/Nevents back.png',
          
           // fit: BoxFit.cover,
           // height: double.infinity,
           // width: double.infinity,
         // ),
         SafeArea(
            child: child!
          ),
        ],
      ),
      
    );
  }
}