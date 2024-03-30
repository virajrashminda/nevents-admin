import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nevents_admin/providers/user_provider.dart';
import 'package:nevents_admin/resoureces/firestore_methods.dart';
import 'package:nevents_admin/utils/utils.dart';

import 'package:provider/provider.dart';

class addpost extends StatefulWidget {
  final Uint8List? file;
  const addpost({Key? key, required this.file}) : super(key: key);

  @override
  State<addpost> createState() => _addpostState();
}

class _addpostState extends State<addpost> {
  final TextEditingController _discriptioncontroller = TextEditingController();
  Uint8List? _file;

  bool _isloading = false;
  void postimage(
    String uid,
    String adminname,
    String imageurl,
  ) async {
    setState(() {
      _isloading = true;
    });
    try {
      String res = await firestoremethods().uploadpost(
        _discriptioncontroller.text,
        widget.file!,
        uid,
        adminname,
        imageurl,
      );

      if (res == 'success') {
        setState(() {
          _isloading = false;
        });
        showSnackBar('Posted !', context);
        Navigator.of(context).pop();
      } else {
        setState(() {
          _isloading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void clearimage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _discriptioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userprovider?>(context)?.getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Color.fromARGB(255, 68, 169, 0)),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text(
          'New post',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => postimage(
              user!.uid,
              user.adminname,
              user.imageurl,
            ),
            child: const Text(
              'Post',
              style: TextStyle(
                color: Color.fromARGB(255, 68, 169, 0),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _isloading
                ? const LinearProgressIndicator(
                    color: Color.fromARGB(255, 68, 169, 0),
                  )
                : Container(),
            if (widget.file != null) ...[
              Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //CircleAvatar(
                      // backgroundImage: NetworkImage(
                      //'https://img.freepik.com/free-vector/university-background-flat-style_23-2147760414.jpg?t=st=1710784481~exp=1710788081~hmac=a6b336a99e973376f74c42dc6b5b6282bc63a959ff6aa762a0910e0ac9384e83&w=740'),
                      //),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: AspectRatio(
                            aspectRatio: 487 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(widget.file!),
                                  fit: BoxFit.fill,
                                  alignment: FractionalOffset.topLeft,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextField(
                            minLines: 1,
                            maxLines: 2,
        
                            controller: _discriptioncontroller,
                            decoration: const InputDecoration(
                              hintText: 'Add a caption...',
                              border: InputBorder.none,
                            ),
                            // maxLines: 8,
                          ),
                        ),
                      ),
                      //const Divider()
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
