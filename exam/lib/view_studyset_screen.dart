import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'library_screen.dart';
import 'edit_studyset.dart';

class ViewStudySetScreen extends StatefulWidget {
  final StudySet studySet;

  const ViewStudySetScreen({Key? key, required this.studySet})
      : super(key: key);

  @override
  _ViewStudySetScreenState createState() => _ViewStudySetScreenState();
}

class _ViewStudySetScreenState extends State<ViewStudySetScreen> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: const Text('Study Set Details',
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
            onPressed: () async {
              final updatedStudySet = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditStudySet(studySet: widget.studySet),
                ),
              );

              if (updatedStudySet != null) {
                setState(() {
                  widget.studySet.title = updatedStudySet['title'];
                  widget.studySet.description = updatedStudySet['description'];
                  widget.studySet.terms = updatedStudySet['terms'];
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Text(
              widget.studySet.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Text(
              'Created by: $userEmail - ${widget.studySet.terms.length} terms',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to flashcard screen
                    },
                    child: Text('Flashcard',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to learn screen
                    },
                    child: Text('Learn', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to test screen
                    },
                    child: Text('Test', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to match screen
                    },
                    child: Text('Match', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 100,
                child: ListView.separated(
                  itemCount: widget.studySet.terms.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "Title: " + widget.studySet.terms[index]['term']!,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        "Definition: " +
                            widget.studySet.terms[index]['definition']!,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
