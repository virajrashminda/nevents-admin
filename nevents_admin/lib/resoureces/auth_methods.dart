import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nevents_admin/models/admin.dart' as models;
import 'package:nevents_admin/resoureces/storage_methods.dart';

class authmethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<models.admin> getuserdetails() async {
    User currentadmin = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('admins').doc(currentadmin.uid).get();

    return models.admin.fromsnap(snap);
  }

  //signup user
  Future<String> signupadmin({
    required String adminname,
    required String bio,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = 'Some error occurred';
    try {
      if (adminname.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);
        String imageurl = await storagemethods()
            .uploadimagetostorage('profile pics', file, false);
        //add user to the data base

        models.admin admin = models.admin(
          adminname: adminname,
          uid: cred.user!.uid,
          followwers: [],
          email: email,
          imageurl: imageurl,
          bio: bio,
        );
        await _firestore
            .collection('admins')
            .doc(cred.user!.uid)
            .set(admin.tojson());

        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  //login the user

  Future<String> loginadmin({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'success';
      } else {
        res = 'please enter the email and password';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
