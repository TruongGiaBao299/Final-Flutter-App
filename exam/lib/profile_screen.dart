import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'JohnDoe';
  String _email = 'johndoe@example.com';
  String _password = 'password123';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Set background color to white
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50), // Adjusted space
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/avatar.png'), // Your avatar image
                  backgroundColor: Colors.transparent, // Transparent background
                  foregroundColor: Colors.black, // Border color
                ),
                const SizedBox(height: 30), // Adjusted space
                Text(
                  _username,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30), // Adjusted space
                PersonalInfoBox(
                  username: _username,
                  email: _email,
                  password: _password,
                  onChanged: (String value) {
                    _updateInfo(value);
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Navigate back to main.dart
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button color
                      elevation: 5, // Shadow elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Colors.grey, // Grey border line
                        ),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey, // Grey text color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateInfo(String value) {
    setState(() {
      _username = value;
    });
  }
}

class PersonalInfoBox extends StatelessWidget {
  final String username;
  final String email;
  final String password;
  final ValueChanged<String> onChanged;

  const PersonalInfoBox({
    Key? key,
    required this.username,
    required this.email,
    required this.password,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        border: Border.all(color: Colors.grey), // Added border line
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow('Username', username, Icons.edit, () {
            _showEditDialog(context, 'Username', username);
          }),
          _buildRow('Email', email, Icons.edit, () {
            _showEditDialog(context, 'Email', email);
          }),
          _buildRow('Password', '*' * password.length, Icons.edit, () {
            _showEditDialog(context, 'Password', password);
          }),
        ],
      ),
    );
  }

  Widget _buildRow(
      String label, String value, IconData icon, VoidCallback onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              icon: Icon(icon),
              onPressed: onPressed,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey, thickness: 1),
        const SizedBox(height: 10),
      ],
    );
  }

  void _showEditDialog(
      BuildContext context, String label, String currentValue) {
    final TextEditingController textEditingController =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextField(
            controller: textEditingController,
            decoration: InputDecoration(hintText: 'Enter new $label'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, textEditingController.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((newValue) {
      if (newValue != null) {
        onChanged(newValue); // Update the value
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$label updated to: $newValue'),
        ));
      }
    });
  }
}
