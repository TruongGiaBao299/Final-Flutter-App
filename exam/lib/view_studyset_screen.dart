import 'package:flutter/material.dart';
import 'library_screen.dart';

class ViewStudySetScreen extends StatelessWidget {
  final StudySet studySet;

  const ViewStudySetScreen({Key? key, required this.studySet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Set Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              studySet.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Created by: User Name - ${studySet.terms.length} terms',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to flashcard screen
                    },
                    child: Text('Flashcard'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to learn screen
                    },
                    child: Text('Learn'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to test screen
                    },
                    child: Text('Test'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to match screen
                    },
                    child: Text('Match'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: studySet.terms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(studySet.terms[index]['term']!),
                  subtitle: Text(studySet.terms[index]['definition']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
