import 'dart:io';
import 'package:Fighton/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);

  final Function({File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 150),
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 95,
                color: Colors.black,
              ),
              onPressed: () async {
                final File imgFile =
                    await ImagePicker.pickImage(source: ImageSource.camera);
                if (imgFile == null) return;
                widget.sendMessage(imgFile: imgFile);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }),
        ],
      ),
    );
  }
}
