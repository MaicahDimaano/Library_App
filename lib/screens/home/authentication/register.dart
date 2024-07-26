import 'package:flutter/material.dart';
import 'package:library_app/screens/home/authentication/pass_validator.dart';
import 'package:library_app/themes.dart';

class RegisterPage extends StatefulWidget {
  static const nameRoute = '/registerPage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _username = '';
  Map<String, bool> _passwordValidationResults = {};
  Map<String, bool> _emailValidationResults = {};
  bool _emailValidated = false;
  bool _passwordValidated = false;
  bool _isPasswordObscured = true; // Flag to toggle password visibility
  bool _isLoginHovered = false;

  void _validateEmail(String value) {
    setState(() {
      _emailValidationResults = EmailValidator.validate(value);
      _emailValidated = true;
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _passwordValidationResults = PasswordValidator.validate(value);
      _passwordValidated = true;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate() &&
        _passwordValidationResults.values.every((result) => result) &&
        _emailValidationResults.values.every((result) => result)) {
      _formKey.currentState!.save();

      // Show the loading dialog
      _showLoadingDialog();

      // Simulate a delay for the registration process
      await Future.delayed(Duration(seconds: 3));

      // Close the loading dialog
      Navigator.of(context).pop();

      // Perform registration logic here

      // Redirect to BottomNavBar after successful registration
      Navigator.pushReplacementNamed(context, '/BottomNavBar');
    }
  }

void _showLoadingDialog() {
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
              SizedBox(height: 16),
              Text(
                "Creating Account...",
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
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('assets/Picks/background.png'), // Use AssetImage for local assets
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(157, 185, 183, 183).withOpacity(0.7),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Circular Logo and title
                    CircleAvatar(
                      backgroundColor: greenColor,
                      radius: 77, // Adjust the radius as needed
                      child: ClipOval(
                        child: Image.network(
                          'assets/Picks/logo.png', // Use Image.asset for local assets
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Register',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Registration form fields
                    _buildTextField(
                      label: 'Username',
                      initialValue: _username,
                      onSaved: (value) => _username = value!,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your username'
                          : null,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      label: 'Email',
                      initialValue: _email,
                      onSaved: (value) => _email = value!,
                      onChanged: (value) {
                        _email = value;
                        _validateEmail(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (_emailValidated && !_emailValidationResults['Valid email format']!) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      label: 'Password',
                      initialValue: _password,
                      obscureText: _isPasswordObscured,
                      onSaved: (value) => _password = value!,
                      onChanged: (value) {
                        _password = value;
                        _validatePassword(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (_passwordValidated && !_passwordValidationResults.values.every((result) => result)) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscured ? Icons.visibility : Icons.visibility_off,
                          color: blackColor,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    if (_passwordValidated)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildValidationItem("Have more than 8 characters", _passwordValidationResults['Have more than 8 characters'] ?? false),
                          _buildValidationItem("Contains a capital letter", _passwordValidationResults['Contains a capital letter'] ?? false),
                          _buildValidationItem("Contains a number", _passwordValidationResults['Contains a number'] ?? false),
                          _buildValidationItem("Contains a special character", _passwordValidationResults['Contains a special character'] ?? false),
                        ],
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _register,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: greenColor, // Set the text color to green
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 250, 249, 249),
                          ),
                        ),
                        MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isLoginHovered = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isLoginHovered = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/loginPage');
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                color: _isLoginHovered ? greenColor : whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for creating text fields
  Widget _buildTextField({
    required String label,
    required String initialValue,
    bool obscureText = false,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    ValueChanged<String>? onChanged,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28.0)),
        filled: true,
        fillColor: Color.fromARGB(197, 255, 255, 255),
        suffixIcon: suffixIcon,
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
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
