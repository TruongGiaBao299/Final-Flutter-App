import 'package:flutter/material.dart';
import 'create_folder.dart';
import 'create_classes.dart';
import 'create_studyset.dart';
import 'view_studyset_screen.dart';
import 'view_folder_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class Folder {
  final String title;
  final String description;

  Folder(this.title, this.description);
}

class StudySet {
  String title;
  String description;
  List<Map<String, String>> terms;

  StudySet({
    required this.title,
    required this.description,
    required this.terms,
  });
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedIndex = 0;
  List<Folder> _folders = [];
  List<StudySet> _studySets = [];
  List<Class> _classes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(Icons.library_books),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Library',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    if (_selectedIndex == 1) {
                      // Handle classes
                      _showCreateClassesScreen(context);
                    } else if (_selectedIndex == 0) {
                      _showCreateStudySetScreen(context);
                    } else if (_selectedIndex == 2) {
                      _createFolder(context);
                    }
                  },
                  icon: Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem('Study Sets', Icons.book, 0),
                _buildNavItem('Classes', Icons.class_, 1),
                _buildNavItem('Folders', Icons.folder, 2),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _buildStudySetsContent(),
                  _buildClassesContent(),
                  _buildFoldersContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String text, IconData iconData, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Icon(
            iconData,
            color: _selectedIndex == index ? Colors.black : Colors.grey,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _selectedIndex == index ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateClassesScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateClasses(),
      ),
    );

    if (result != null) {
      setState(() {
        _classes.add(Class(result['title'], result['description']));
      });
    }
  }

  void _showCreateStudySetScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateStudySet(),
      ),
    );

    if (result != null) {
      setState(() {
        _studySets.add(StudySet(
          title: result['title']!,
          description: result['description']!,
          terms: List<Map<String, String>>.from(result['terms']!),
        ));
      });
    }
  }

  void _createFolder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateFolder(
          onSave: (title, description) {
            setState(() {
              _folders.add(Folder(title, description));
            });
          },
        ),
      ),
    );
  }

  Widget _buildStudySetsContent() {
    return ListView.builder(
      itemCount: _studySets.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100, // Set a fixed height for each card
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewStudySetScreen(studySet: _studySets[index]),
                ),
              );
            },
            child: _buildStudySetCard(context, _studySets[index]),
          ),
        );
      },
    );
  }

  Widget _buildStudySetCard(BuildContext context, StudySet studySet) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(studySet.title),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(studySet.description),
            SizedBox(
              width: 10,
            ),
            Text('Terms: ${studySet.terms.length}'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              _studySets.remove(studySet);
            });
          },
        ),
      ),
    );
  }

  Widget _buildClassesContent() {
    return ListView.builder(
      itemCount: _classes.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100, // Set a fixed height for each card
          child: _buildClassCard(context, _classes[index]),
        );
      },
    );
  }

  Widget _buildClassCard(BuildContext context, Class classItem) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        leading: const Icon(Icons.class_),
        title: Text(classItem.title),
        subtitle: Text(classItem.description),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              _classes.remove(classItem);
            });
          },
        ),
      ),
    );
  }

  Widget _buildFoldersContent() {
    return ListView.builder(
      itemCount: _folders.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100, // Set a fixed height for each card
          child: GestureDetector(
            onTap: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => 
                    ViewFolderScreen(folder: _folders[index])),
          ),
          child: _buildFolderCard(context, _folders[index]),
        ));
      },
    );
  }

  Widget _buildFolderCard(BuildContext context, Folder folder) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListTile(
        leading: const Icon(Icons.folder),
        title: Text(folder.title),
        subtitle: Text(folder.description),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              _folders.remove(folder);
            });
          },
        ),
      ),
    );
  }
}

class Class {
  final String title;
  final String description;

  Class(this.title, this.description);
}

void main() {
  runApp(MaterialApp(
    home: LibraryScreen(),
  ));
}