import 'package:flutter/material.dart';

class CheckBoxDialog extends StatefulWidget {
  @override
  _CheckBoxDialogState createState() => _CheckBoxDialogState();
}

class _CheckBoxDialogState extends State<CheckBoxDialog> {
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Checkbox Dialog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text('Checkbox 1'),
            value: checkBox1,
            onChanged: (value) {
              setState(() {
                checkBox1 = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Checkbox 2'),
            value: checkBox2,
            onChanged: (value) {
              setState(() {
                checkBox2 = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Checkbox 3'),
            value: checkBox3,
            onChanged: (value) {
              setState(() {
                checkBox3 = value!;
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            'Sample Text',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

