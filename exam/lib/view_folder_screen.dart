import 'package:flutter/material.dart';
import 'library_screen.dart'; // Import file chứa lớp StudySet

class ViewFolderScreen extends StatelessWidget {
  final Folder folder;

  const ViewFolderScreen({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: const Text('Folder Details',
          style: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Center(child: Container(child: Text('HELLO'))));
  }
}