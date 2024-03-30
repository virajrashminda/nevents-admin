import 'package:cloud_firestore/cloud_firestore.dart';

class post{
  
  

  final String description;
  final String uid;
  final String adminname;
  final String postid;
  final  dateofpublished;
  final String photourl;
  final String imageurl;
  final  likes;
  final participating;
  final maybe;

  const post({

    required this.adminname,
    required this.uid,
    required this.description,
    required this.postid,
    required this.dateofpublished,
    required this.photourl,
    required this.imageurl,
    required this.likes,
    required this.participating,
    required this.maybe,
    
  });

  Map<String,dynamic> tojson() => {

    'admin name':adminname,
    'uid':uid,
    'description':description,
    'postid':postid,
    'dateofpublished':dateofpublished,
    'photourl':photourl,
    'imageurl':imageurl,
    'likes':likes,
    'participating':participating,
    'may be':maybe,
  };

  

  static post fromsnap(DocumentSnapshot snap){
    
    var snapshot = snap.data() as Map<String,dynamic>;
    
    return post(
      
      adminname: snapshot['admin name']?? '',
      uid: snapshot['uid']?? '',
      description: snapshot['descriptin']??'',
      postid: snapshot['postid']??'',
      photourl: snapshot['photourl']??'',
      imageurl: snapshot['imageurl']??'',
      likes: snapshot['likes']??'',
      participating: snapshot['participating'],
      maybe: snapshot['may be'],
      dateofpublished: snapshot['dateofpublished']??'',
    );
  }
}