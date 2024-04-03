import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nevents_admin/resoureces/auth_methods.dart';
import 'package:nevents_admin/screens/login.dart';
import 'package:nevents_admin/utils/utils.dart';
import 'package:nevents_admin/widgets/singout_button.dart';


class profile extends StatefulWidget {
  final uid;
  const profile({super.key, required this.uid});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Uint8List? _file;
  int followers = 0;
  var userdata = {};
  int postlen = 0;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    setState(() {
      isloading = true;
    });
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection('admins')
          .doc(widget.uid)
          .get();
      //get post
      var postsnap = await FirebaseFirestore.instance
          .collection('posts')
          .where(
            'uid',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();
      postlen = postsnap.docs.length;
      userdata = usersnap.data()!;
      followers = usersnap.data()!['followers'].length;
      setState(() {});
    } catch (e) {
      showSnackBar(
        context as String,
        e.toString() as BuildContext,
      );
    }
    setState(() {
      isloading = false;
    });
  }

  //void _selectimage() async {
  //Uint8List im = await pickimage(ImageSource.gallery);
  //setState(() {
  // _img = im;
  // });
  //}

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(203, 68, 169, 0),
            ),
          )
        : Scaffold(
            body: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          child: //_img != null?
                              //CircleAvatar(
                              //radius: 74.0,
                              //backgroundColor: Colors.white,
                              //backgroundImage: MemoryImage(_img!),
                              //)
                              CircleAvatar(
                            radius: 74.0,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              userdata['imageurl'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          userdata['admin name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          userdata['bio'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.black45),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildstatecolumn(postlen, 'Posts'),
                        const SizedBox(
                          width: 23,
                        ),
                        buildstatecolumn(followers, 'Followers'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        signoutbutton(
                          function: () async {
                            await authmethods().signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const login(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(203, 68, 169, 0),
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        return Container(
                          child: Image(
                            image: NetworkImage(
                              snap['photourl'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
  }

  Column buildstatecolumn(int num, String lable) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          lable,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }
}
