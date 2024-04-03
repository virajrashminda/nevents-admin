import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nevents_admin/models/post.dart';
import 'package:nevents_admin/resoureces/storage_methods.dart';

import 'package:uuid/uuid.dart';

class firestoremethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadpost(
    String description,
    Uint8List file,
    String uid,
    String adminname,
    String imageurl,
  ) async {
    String res = 'some error occured';
    try {
      String photourl =
          await storagemethods().uploadimagetostorage('posts', file, true);
      String postid = const Uuid().v1();
      post _post = post(
        adminname: adminname,
        uid: uid,
        description: description,
        postid: postid,
        dateofpublished: DateTime.now(),
        photourl: photourl,
        imageurl: imageurl,
        likes: [],
        participating: [],
        maybe: [],
      );
      _firestore.collection('posts').doc(postid).set(
            _post.tojson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likepost(String postid, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postcomment(
      String postid, String text, String uid, String username,String profilepic) async {
    try {
      if (text.isNotEmpty) {
        String commentid = Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postid)
            .collection('comments')
            .doc(commentid)
            .set({
          'name': username,
          'profilepic': profilepic,
          'uid': uid,
          'text': text,
          'commentid': commentid,
          'dateofpublished': DateTime.now(),
        });
      } else {
        print('text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletepost(String postid) async {
    try {
      await _firestore.collection('posts').doc(postid).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followadmin(String uid, String followId) async {
    try {
      // Update the admin document
      DocumentSnapshot adminSnapshot =
          await _firestore.collection('admins').doc(followId).get();
      List<dynamic> adminFollowers =
          (adminSnapshot.data() as Map<String, dynamic>)['followers'] ?? [];
      if (adminFollowers.contains(uid)) {
        await _firestore.collection('admins').doc(followId).update({
          'followers': adminFollowers..remove(uid),
        });
      } else {
        await _firestore.collection('admins').doc(followId).update({
          'followers': adminFollowers..add(uid),
        });
      }

      // Update the user document
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(uid).get();
      List<dynamic> userFollowing =
          (userSnapshot.data() as Map<String, dynamic>)['following'] ?? [];
      if (userFollowing.contains(followId)) {
        await _firestore.collection('users').doc(uid).update({
          'following': userFollowing..remove(followId),
        });
      } else {
        await _firestore.collection('users').doc(uid).update({
          'following': userFollowing..add(followId),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
