import 'package:flutter/material.dart';
import 'package:library_app/screens/home/authentication/pass_validator.dart';
import 'package:library_app/screens/user_account/password_utils.dart';
import 'package:library_app/themes.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _useBiometrics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor, // Consistent color with LoginPage
        title: Text('Security', style: TextStyle(color: blackColor)),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordPage(),
                ),
              );
            },
          ),
          Divider(height: 1, color: Colors.grey),
          SwitchListTile(
            title: Text('Use Biometrics', style: TextStyle(fontSize: 18)),
            value: _useBiometrics,
            onChanged: (value) {
              setState(() {
                _useBiometrics = value;
              });
            },
            secondary: Icon(
              Icons.fingerprint,
              color: _useBiometrics ? greenColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  Map<String, bool> _passwordValidationResults = {};
  bool _passwordsMatch = true;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isValidPassword = true;
  bool _fieldsFilled = true;
  bool _isPasswordValidated = false;

  void _validateNewPassword(String value) {
    setState(() {
      _passwordValidationResults = PasswordValidator.validate(value);
      _isPasswordValidated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text('Change Password', style: TextStyle(color: blackColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                filled: true,
                fillColor: Color.fromARGB(197, 255, 255, 255),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _newPasswordController,
              obscureText: !_isNewPasswordVisible,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                filled: true,
                fillColor: Color.fromARGB(197, 255, 255, 255),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: blackColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                ),
              ),
              onChanged: (value) {
                _validateNewPassword(value);
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                filled: true,
                fillColor: Color.fromARGB(197, 255, 255, 255),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: blackColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            if (_isPasswordValidated)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildValidationItem("Have more than 8 characters", _passwordValidationResults['Have more than 8 characters'] ?? false),
                  _buildValidationItem("Contains a capital letter", _passwordValidationResults['Contains a capital letter'] ?? false),
                  _buildValidationItem("Contains a number", _passwordValidationResults['Contains a number'] ?? false),
                  _buildValidationItem("Contains a special character", _passwordValidationResults['Contains a special character'] ?? false),
                ],
              ),
            Visibility(
              visible: !_fieldsFilled,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Please fill in all fields!',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            Visibility(
              visible: !_passwordsMatch,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Passwords do not match!',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _changePassword(context);
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: whiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
                SizedBox(width: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: greyColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationItem(String text, bool isValid) {
    return Row(
      children: <Widget>[
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? Colors.green : Colors.red,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: blackColor,
          ),
        ),
      ],
    );
  }

  void _changePassword(BuildContext context) {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    setState(() {
      _fieldsFilled = oldPassword.isNotEmpty && newPassword.isNotEmpty && confirmPassword.isNotEmpty;
      _isValidPassword = isValidPassword(newPassword);
      _passwordsMatch = newPassword == confirmPassword;
    });

    if (_fieldsFilled && _isValidPassword && _passwordsMatch) {
      // Proceed with password change logic
      Navigator.of(context).pop(); // Close ChangePasswordPage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password changed successfully!'),
        ),
      );
    }
  }
}
