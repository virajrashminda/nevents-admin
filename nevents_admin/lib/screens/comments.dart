import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nevents_admin/providers/user_provider.dart';
import 'package:nevents_admin/resoureces/firestore_methods.dart';
import 'package:nevents_admin/widgets/commentcard.dart';


import 'package:provider/provider.dart';

class comments extends StatefulWidget {
  final snap;
  const comments({super.key, required this.snap});

  @override
  State<comments> createState() => _commentsState();
}

class _commentsState extends State<comments> {
  final TextEditingController _commentcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userprovider?>(context)?.getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Comments',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postid'])
            .collection('comments')
            .orderBy('dateofpublished', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, Index) => commentcard(
              snap: (snapshot.data! as dynamic).docs[Index].data(),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                user?.imageurl ?? '',
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: _commentcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  await firestoremethods().postcomment(
                    widget.snap['postid'],
                    _commentcontroller.text,
                    user?.uid ?? '',
                    user?.adminname ?? '',
                    user?.imageurl??'',
                  );
                  setState(() {
                    _commentcontroller.text = '';
                  });
                },
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 68, 169, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
