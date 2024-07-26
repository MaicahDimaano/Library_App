import 'package:flutter/material.dart';
import 'package:library_app/themes.dart';

class EditProfilePage extends StatefulWidget {
  final void Function(String newName, String newBio) onUpdateProfile;

  EditProfilePage({required this.onUpdateProfile});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 90.0,
                  backgroundImage: NetworkImage('assets/images/user.png'), // Replace with actual image path
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'New Username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _bioController,
                decoration: InputDecoration(
                  labelText: 'New Bio',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new bio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onUpdateProfile(
                        _nameController.text,
                        _bioController.text,
                      );
                      Navigator.pop(context, 'Profile updated successfully!');
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: whiteColor), // White text color
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor, // Green button color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
