import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nevents_admin/screens/homefeed.dart';
import 'package:nevents_admin/screens/profile.dart';
import 'package:nevents_admin/screens/select_post.dart';

List<Widget> homescreenitems = [
  homefeed(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  SelectPost(),
  profile(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
