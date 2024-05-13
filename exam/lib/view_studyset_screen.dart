import 'package:flutter/material.dart';
import 'library_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewStudySetScreen extends StatelessWidget {
  final StudySet studySet;

  const ViewStudySetScreen({Key? key, required this.studySet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve current user's email from Firebase
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set background to transparent
        elevation: 0, // Remove the shadow
        title: Center(
          child: const Text('Study Set Details',
              style: TextStyle(color: Colors.black)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Set icon color to black
          onPressed: () {
            Navigator.of(context).pop(); // Go to previous page
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert,
                color: Colors.black), // Set icon color to black
            onPressed: () {
              // Show options menu
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
              studySet.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set text color to black
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
            child: Text(
              'Created by: $userEmail - ${studySet.terms.length} terms',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Set text color to black
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
                        style: TextStyle(
                            color: Colors.white)), // Set text color to white
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to learn screen
                    },
                    child: Text('Learn',
                        style: TextStyle(
                            color: Colors.white)), // Set text color to white
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
                    child: Text('Test',
                        style: TextStyle(
                            color: Colors.white)), // Set text color to white
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to match screen
                    },
                    child: Text('Match',
                        style: TextStyle(
                            color: Colors.white)), // Set text color to white
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
                  itemCount: studySet.terms.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Title: " + studySet.terms[index]['term']!,
                          style: TextStyle(
                              color: Colors.black)), // Set text color to black
                      subtitle: Text(
                          "Definition: " + studySet.terms[index]['definition']!,
                          style: TextStyle(
                              color: Colors.black)), // Set text color to black
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
