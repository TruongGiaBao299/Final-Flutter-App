import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = 'JohnDoe';
  String _email = 'johndoe@example.com';
  String _password = 'password123';
  bool _pushNotificationsEnabled = true;
  bool _soundEffectsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/avatar/avatar.png'), // Updated path
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    _username,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Personal info',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                PersonalInfoBox(
                  username: _username,
                  email: _email,
                  password: _password,
                  onChanged: (String username, String email, String password) {
                    _updateInfo(username, email, password);
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Preferences',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                PreferencesInfoBox(
                  pushNotificationsEnabled: _pushNotificationsEnabled,
                  soundEffectsEnabled: _soundEffectsEnabled,
                  onToggle: (bool pushNotifications, bool soundEffects) {
                    setState(() {
                      _pushNotificationsEnabled = pushNotifications;
                      _soundEffectsEnabled = soundEffects;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateInfo(String username, String email, String password) {
    setState(() {
      _username = username;
      _email = email;
      _password = password;
    });
  }
}

class PersonalInfoBox extends StatelessWidget {
  final String username;
  final String email;
  final String password;
  final Function(String, String, String) onChanged;

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
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey),
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
        if (label == 'Username') {
          onChanged(newValue, email, password);
        } else if (label == 'Email') {
          onChanged(username, newValue, password);
        } else if (label == 'Password') {
          onChanged(username, email, newValue);
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$label updated to: $newValue'),
        ));
      }
    });
  }
}

class PreferencesInfoBox extends StatelessWidget {
  final bool pushNotificationsEnabled;
  final bool soundEffectsEnabled;
  final Function(bool, bool) onToggle;

  const PreferencesInfoBox({
    Key? key,
    required this.pushNotificationsEnabled,
    required this.soundEffectsEnabled,
    required this.onToggle,
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
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSwitchTile(
            'Push Notifications',
            pushNotificationsEnabled,
            (value) {
              onToggle(value, soundEffectsEnabled);
            },
          ),
          _buildSwitchTile(
            'Sound Effects',
            soundEffectsEnabled,
            (value) {
              onToggle(pushNotificationsEnabled, value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
