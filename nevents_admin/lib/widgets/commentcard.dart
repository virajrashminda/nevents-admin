import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class commentcard extends StatefulWidget {
  final snap;
  const commentcard({super.key,required this.snap});

  @override
  State<commentcard> createState() => _commentcardState();
}

class _commentcardState extends State<commentcard> {
  @override
  Widget build(BuildContext context) {
    //print('User name: ${widget.snap['name']}');
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
             ''
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.snap['name']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                              
                        ),
                       TextSpan(text: 's'),
                        TextSpan(
                          text: DateFormat.yMMMd().format(
                            widget.snap['dateofpublished'].toDate(),
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(widget.snap['text']),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: const Icon(
              Icons.favorite,
              size: 16,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
