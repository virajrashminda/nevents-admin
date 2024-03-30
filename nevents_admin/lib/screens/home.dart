import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nevents_admin/providers/user_provider.dart';
import 'package:nevents_admin/utils/gloable_variable.dart';

import 'package:provider/provider.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //fetching user data not work properly whatch te video from 2.30
  @override
  int _page = 0;
  late PageController pageController;

  void navigationtap(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void initState() {
    super.initState();
    addData();
    pageController = PageController();
  }

  addData() async {
    userprovider _userprovider = Provider.of(context, listen: false);

    await _userprovider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userprovider?>(context)?.getUser;
    if (user != null) {
    } else {
      
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/Nevents.svg',
          height: 50,
        ),
        
      ),
      body: Center(
          child: PageView(
        children: homescreenitems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (int page) {
          setState(() {
            _page = page;
          });
        },
      )
          //Text(user?.email??'user name not available',style: TextStyle(color: Colors.black),),
          ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color.fromARGB(255, 68, 169, 0),
          color: Color.fromARGB(255, 68, 169, 0),
          animationDuration: const Duration(milliseconds: 300),
          items: const [
            Icon(Icons.home, size: 26, color: Colors.white),
            Icon(Icons.add_circle, size: 26, color: Colors.white),
            Icon(Icons.notifications, size: 26, color: Colors.white),
            Icon(Icons.person, size: 26, color: Colors.white),
          ],
          onTap: navigationtap),
    );
  }
}
