import 'package:flutter/material.dart';
import 'create_studyset.dart';
import 'create_classes.dart';
import 'create_folder.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20), // Some top space
            const Text(
              'Library',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Some space between title and content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem('Study Sets', 0),
                _buildNavItem('Classes', 1),
                _buildNavItem('Folders', 2),
              ],
            ),
            const SizedBox(height: 20), // Some space between content and bottom
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  Center(
                    child: StudySetsContent(
                      onCreateNew: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateStudySet()),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ClassesContent(
                      onCreateNew: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateClasses()),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: FoldersContent(
                      onCreateNew: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateFolder()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  _selectedIndex == index ? Colors.black : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _selectedIndex == index ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Create Study Set'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                if (_selectedIndex == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateStudySet()),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Create Folder'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                if (_selectedIndex == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateFolder()),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.class_),
              title: const Text('Create Class'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                if (_selectedIndex == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateClasses()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class StudySetsContent extends StatelessWidget {
  final VoidCallback onCreateNew;

  const StudySetsContent({required this.onCreateNew});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onCreateNew,
          child: const Text('Create New Study Set'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class ClassesContent extends StatelessWidget {
  final VoidCallback onCreateNew;

  const ClassesContent({required this.onCreateNew});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onCreateNew,
          child: const Text('Create New Class'),
        ),
      ],
    );
  }
}

class FoldersContent extends StatelessWidget {
  final VoidCallback onCreateNew;

  const FoldersContent({required this.onCreateNew});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onCreateNew,
          child: const Text('Create New Folder'),
        ),
      ],
    );
  }
}
