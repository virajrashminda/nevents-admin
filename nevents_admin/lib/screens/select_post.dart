import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nevents_admin/screens/addpost.dart';

class SelectPost extends StatelessWidget {
  const SelectPost({super.key});

  Future<void> _selectImageToPost(BuildContext context) async {
    Uint8List? file = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Center(
            child: Text(
              'Upload Image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          children: [
            Center(
              child: SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Take a photo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await _pickImage(ImageSource.camera));
                },
              ),
            ),
            const Divider(
              color: Colors.black26,
              indent: 20,
              endIndent: 20,
            ),
            Center(
              child: SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Choose from gallery',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                onPressed: () async {
                  Navigator.of(context)
                      .pop(await _pickImage(ImageSource.gallery));
                },
              ),
            ),
            const Divider(
              color: Colors.black26,
              indent: 20,
              endIndent: 20,
            ),
            Center(
              child: SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
            ),
          ],
        );
      },
    );

    if (file != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => addpost(file: file),
        ),
      );
    }
  }

  Future<Uint8List?> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: SizedBox(
                height: 300,
                width: 300,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://t3.ftcdn.net/jpg/04/60/01/36/360_F_460013622_6xF8uN6ubMvLx0tAJECBHfKPoNOR5cRa.jpg',
                        ),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topLeft,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _selectImageToPost(context),
                    
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromARGB(203, 68, 169, 0),
                  ),
                  child: const Text(
                    '+ Add new post',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
