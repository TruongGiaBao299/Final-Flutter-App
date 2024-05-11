import 'package:flutter/material.dart';
import 'create_folder.dart';
import 'create_classes.dart';
import 'create_studyset.dart';

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

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedIndex = 0;
  List<Folder> _folders = []; // List to hold folder information

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20), // Some top space
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateClasses()),
                      );
                    } else if (_selectedIndex == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateStudySet()),
                      );
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
                  StudySetsContent(),
                  ClassesContent(),
                  FoldersContent(
                    onCreateNew: () {
                      _createFolder(context);
                    },
                    folders: _folders,
                    onDelete: (folder) {
                      setState(() {
                        _folders.remove(folder);
                      });
                    },
                  ),
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
}

class StudySetsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Study Sets Content'),
    );
  }
}

class ClassesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Classes Content'),
    );
  }
}

class FoldersContent extends StatelessWidget {
  final VoidCallback onCreateNew;
  final List<Folder> folders;
  final Function(Folder) onDelete;

  const FoldersContent(
      {required this.onCreateNew,
      required this.folders,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: folders.length,
      itemBuilder: (context, index) {
        return _buildFolderCard(context, folders[index]);
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
            onDelete(folder);
          },
        ),
      ),
    );
  }
}
