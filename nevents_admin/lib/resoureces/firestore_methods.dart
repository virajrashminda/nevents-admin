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
          res= 'success';
          
    } catch (err) {
      res= err.toString();
    }
    return res;
  }
  Future<void>likepost(String postid,String uid,List likes)async{
    try{
      if(likes.contains(uid)){
       await _firestore.collection('posts').doc(postid).update({
         'likes':FieldValue.arrayRemove([uid]),
        });
      }else{
       await _firestore.collection('posts').doc(postid).update({
         'likes':FieldValue.arrayUnion([uid]),
        });
      }
    }catch(e){
      print(e.toString());
    }
  }
  Future<void>postcomment(String postid,String text,String uid,String username)async{
    try{
      if(text.isNotEmpty){
        String commentid=Uuid().v1();
       await _firestore.collection('posts').doc(postid).collection('comments').doc(commentid).set({
          'name':username,
          'uid':uid,
          'text':text,
          'commentid':commentid,
          'dateofpublished':DateTime.now(),
       });
       
      }else{
       print('text is empty');
      }
    }catch(e){
      print(e.toString());
    }
  }
  
   Future<void>deletepost(String postid)async{
    try{
      
       await _firestore.collection('posts').doc(postid).delete();
       
          
      
    }catch(e){
      print(e.toString());}
    }
  
}
