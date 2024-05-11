import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'library_screen.dart';
import 'solution_screen.dart';
import 'create_studyset.dart';
import 'create_folder.dart';
import 'create_classes.dart';

void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateStudySet(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Create Folder'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateFolder(
                      onSave: (title, description) {
                        // Here you can handle saving the folder data
                        print('Title: $title, Description: $description');
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.class_),
              title: const Text('Create Class'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateClasses(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          SolutionScreen(),
          LibraryScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 40.0,
        height: 40.0,
        child: FloatingActionButton(
          onPressed: () {
            _showAddOptions(context);
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        selectedIconTheme: IconThemeData(size: 28.0),
        unselectedIconTheme: IconThemeData(size: 28.0),
        selectedLabelStyle: TextStyle(fontSize: 14.0),
        unselectedLabelStyle: TextStyle(fontSize: 14.0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb, size: 20.0),
            label: 'Solution',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books, size: 20.0),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 20.0),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
