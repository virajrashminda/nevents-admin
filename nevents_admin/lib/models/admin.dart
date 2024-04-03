import 'package:cloud_firestore/cloud_firestore.dart';

class admin {
  final String adminname;
  final String uid;
  final String imageurl;
  final String email;
  final String bio;
  final List followwers;

  const admin({
    required this.adminname,
    required this.uid,
    required this.imageurl,
    required this.email,
    required this.followwers,
    required this.bio,
  });

  Map<String, dynamic> tojson() => {
        'admin name': adminname,
        'uid': uid,
        'imageurl': imageurl,
        'email': email,
        'followers': followwers,
        'bio': bio,
      };

  static admin fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return admin(
      adminname: snapshot['admin name'] ?? '',
      uid: snapshot['uid'] ?? '',
      followwers: snapshot['followers'] ?? '',
      email: snapshot['email'] ?? '',
      imageurl: snapshot['imageurl'] ?? '',
      bio: snapshot['bio'] ?? '',
    );
  }
}
