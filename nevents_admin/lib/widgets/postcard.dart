import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nevents_admin/providers/user_provider.dart';
import 'package:nevents_admin/resoureces/firestore_methods.dart';
import 'package:nevents_admin/screens/comments.dart';
import 'package:nevents_admin/utils/utils.dart';
import 'package:nevents_admin/widgets/like_animation.dart';
import 'package:provider/provider.dart';

class postcard extends StatefulWidget {
  final snap;

  const postcard({
    super.key,
    required this.snap,
  });

  @override
  State<postcard> createState() => _postcardState();
}

class _postcardState extends State<postcard> {
  bool islikeanimating = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  int commentlenth = 0;
  @override
  void initState() {
    super.initState();
    getcomments();
  }

  void getcomments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postid'])
          .collection('comments')
          .get();
      commentlenth = snap.docs.length;
    } catch (e) {
      showSnackBar((e).toString(), context);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final admin = Provider.of<userprovider?>(context)?.getUser;
    return Container(
      color: Colors.white30,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              //header section
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.snap['imageurl'] ?? ''),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 9),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['admin name'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          DateFormat.yMMMd().format(
                            (widget.snap['dateofpublished'] as Timestamp?)
                                    ?.toDate() ??
                                DateTime.now(),
                          ),
                          style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: [
                            const Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ]
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    firestoremethods()
                                        .deletepost(widget.snap['postid']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: e,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 380,
                padding: const EdgeInsets.only(left: 20),
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: widget.snap['description'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                      ]),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          //image section
          GestureDetector(
            onDoubleTap: () async {
              await firestoremethods().likepost(
                widget.snap['postid'],
                admin?.uid ?? '',
                widget.snap['likes'],
              );
              setState(() {
                islikeanimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.47,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['photourl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: islikeanimating ? 1 : 0,
                  child: likeanimation(
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 100,
                    ),
                    isanimating: islikeanimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onend: () {
                      setState(() {
                        islikeanimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          //like comment section
          Row(
            children: [
              likeanimation(
                isanimating: widget.snap['likes'].contains(admin?.uid),
                smalllike: true,
                child: IconButton(
                  onPressed: () async {
                    await firestoremethods().likepost(
                      widget.snap['postid'],
                      admin?.uid ?? '',
                      widget.snap['likes'],
                    );
                  },
                  icon: widget.snap['likes'].contains(admin?.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => comments(
                      snap: widget.snap,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.insert_comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Student choices',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'participating',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black45),
                              ),
                              const SizedBox(
                                width: 55,
                              ),
                              Text(
                                '${widget.snap['participating'].length} ',
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'May be',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black45),
                              ),
                              const SizedBox(
                                width: 99,
                              ),
                              Text(
                                '${widget.snap['may be'].length} ',
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.graphic_eq),
              ),
              const SizedBox(width: 165),
              const Icon(
                Icons.insert_comment,
                size: 15,
              ),
              Text(
                '$commentlenth',
                style: const TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.favorite_border,
                size: 15,
                color: Colors.red,
              ),
              Text(
                '${widget.snap['likes'].length} ',
                style: const TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
