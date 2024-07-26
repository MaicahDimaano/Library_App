import 'package:flutter/material.dart';
import 'package:library_app/screens/home/authentication/login.dart';
import 'edit_profile.dart';
import 'security.dart';
import 'package:library_app/themes.dart';

class SettingsPage extends StatelessWidget {
  final void Function(String newName, String newBio) onUpdateProfile;

  SettingsPage({required this.onUpdateProfile});

  Future<void> _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(greenColor),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Logging Out...",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _logout(BuildContext context) async {
    // Show loading dialog
    _showLoadingDialog(context);

    // Simulate a delay for logout process
    await Future.delayed(const Duration(seconds: 2));

    // Close loading dialog
    Navigator.of(context).pop(); // Close the loading dialog

    // Navigate to login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _deleteAccount(BuildContext context) async {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Confirm Delete Account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Are you sure you want to delete your account?',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Delete', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        // Navigate to login page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account Deleted Successfully!'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(
                          onUpdateProfile: onUpdateProfile,
                        ),
                      ),
                    ).then((result) {
                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                      }
                    });
                  },
                ),
                const Divider(color: Colors.black, thickness: 1.0),
              ],
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.security, color: Colors.black),
                title: const Text('Security', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecurityPage(),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.black, thickness: 1.0),
            ],
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.cached, color: Colors.black),
                  title: const Text('Clear Cache', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cache cleared'),
                      ),
                    );
                  },
                ),
                const Divider(color: Colors.black, thickness: 1.0),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  title: const Center(child: Text('Logout', style: TextStyle(color: Colors.red))),
                  onTap: () {
                    _logout(context);
                  },
                ),
                const Divider(color: Colors.black, thickness: 1.0),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  title: const Center(child: Text('Delete Account', style: TextStyle(color: Colors.red))),
                  onTap: () {
                    _deleteAccount(context);
                  },
                ),
                const Divider(color: Colors.black, thickness: 1.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
