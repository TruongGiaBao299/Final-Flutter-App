import 'package:exam/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/profile': (context) => MyApp()},
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
  late User? _user;
  bool _pushNotificationsEnabled = true;
  bool _soundEffectsEnabled = true;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

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
                const SizedBox(
                    height: 20), // Reduced the space between avatar and text
                Center(
                  child: Text(
                    _user != null
                        ? _user!.email ?? 'No Email'
                        : 'Loading...', // Changed to user's email
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold // Reduced font size
                        ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Personal info',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _user != null
                    ? PersonalInfoBox(
                        email: _user!.email ?? 'No Email',
                        password: _user!.email != null
                            ? '*' *
                                _user!.email!.length // Password with asterisks
                            : '******',
                        onChanged: (String email, String password) {
                          // No need to update email and password here, Firebase Auth handles them
                        },
                        onChangePassword: () {
                          _showChangePasswordDialog(context);
                        },
                      )
                    : CircularProgressIndicator(), // Show loading indicator while waiting for Firebase
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
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);
                      Navigator.of(context).pushReplacementNamed('/login');
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

  void _showChangePasswordDialog(BuildContext context) {
    String oldPassword = '';
    String newPassword = '';
    String confirmPassword = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Old Password'),
                onChanged: (value) {
                  oldPassword = value;
                },
                obscureText: true,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'New Password'),
                onChanged: (value) {
                  newPassword = value;
                },
                obscureText: true,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                onChanged: (value) {
                  confirmPassword = value;
                },
                obscureText: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (newPassword == confirmPassword) {
                  try {
                    // Reauthenticate user
                    AuthCredential credential = EmailAuthProvider.credential(
                        email: _user!.email!, password: oldPassword);
                    await _user!.reauthenticateWithCredential(credential);
                    // Update password
                    await _user!.updatePassword(newPassword);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password changed successfully'),
                      ),
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Failed to change password. Please try again.'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match'),
                    ),
                  );
                }
              },
              child: Text('Change'),
            ),
          ],
        );
      },
    );
  }
}

class PersonalInfoBox extends StatelessWidget {
  final String email;
  final String password;
  final Function(String, String) onChanged;
  final VoidCallback? onChangePassword;

  const PersonalInfoBox({
    Key? key,
    required this.email,
    required this.password,
    required this.onChanged,
    this.onChangePassword,
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
          _buildRow('Email', email, Icons.mail, () {
            // No action needed, email is managed by Firebase
          }),
          _buildRow('Password', password, Icons.lock, () {
            if (onChangePassword != null) onChangePassword!();
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
      ],
    );
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
