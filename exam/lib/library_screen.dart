import 'package:flutter/material.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Some top space
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Library',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Add your action here
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
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
                  StudySetsContent(),
                  ClassesContent(
                    onCreateNew: () {
                      // Add your action to create new class
                    },
                  ),
                  FoldersContent(
                    onCreateNew: () {
                      // Add your action to create new folder
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
}

class StudySetsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Study Sets Content',
        style: TextStyle(fontSize: 20),
      ),
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
        Center(
          child: ElevatedButton(
            onPressed: onCreateNew,
            child: const Text('Create New Class'),
          ),
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
        Center(
          child: ElevatedButton(
            onPressed: onCreateNew,
            child: const Text('Create New Folder'),
          ),
        ),
      ],
    );
  }
}
