import 'package:flutter/material.dart';
import 'package:library_app/screens/home/authentication/pass_validator.dart';
import 'package:library_app/themes.dart';

class LoginPage extends StatefulWidget {
  static const nameRoute = '/loginPage';

  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _passwordValidationMessage = '';
  String _emailValidationMessage = '';
  bool _isPasswordObscured = true; // Flag to toggle password visibility
  bool _isRegisterHovered = false;

  void _validateEmail(String value) {
    final validationResults = EmailValidator.validate(value);
    if (validationResults['Valid email format'] == true) {
      _emailValidationMessage = '';
    } else {
      _emailValidationMessage = 'Please enter a valid email';
    }
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      _passwordValidationMessage = 'Password is required';
    } else if (value.length < 8) {
      _passwordValidationMessage = 'Password must have more than 8 characters';
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      _passwordValidationMessage = 'Password must contain a capital letter';
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      _passwordValidationMessage = 'Password must contain a number';
    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _passwordValidationMessage = 'Password must contain a special character';
    } else {
      _passwordValidationMessage = '';
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate() &&
        _passwordValidationMessage.isEmpty &&
        _emailValidationMessage.isEmpty) {
      _formKey.currentState!.save();
      _showLoadingDialog(); // Show loading dialog

      // Simulate login delay
      await Future.delayed(const Duration(seconds: 2));

      // Perform login logic here
      Navigator.pop(context); // Dismiss loading dialog
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
              const SizedBox(height: 16),
              const Text(
                "Logging in to BookQuest...",
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
                image: const NetworkImage(
                    'assets/Picks/background.png'), // Replace with your background image path
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    const Color.fromARGB(157, 185, 183, 183).withOpacity(0.7),
                    BlendMode.darken), // Adjust opacity here
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: greenColor,
                      radius: 77,
                      child: ClipOval(
                        child: Image.network(
                          'assets/Picks/logo.png', // Replace with your logo asset path
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: whiteColor, // Text color similar to register page
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: _email,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0)),
                        filled: true,
                        fillColor: const Color.fromARGB(197, 255, 255, 255),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                          _validateEmail(value);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (_emailValidationMessage.isNotEmpty) {
                          return _emailValidationMessage;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: _password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0)),
                        filled: true,
                        fillColor: const Color.fromARGB(197, 255, 255, 255),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: blackColor,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: _isPasswordObscured,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                          _validatePassword(value);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (_passwordValidationMessage.isNotEmpty) {
                          return _passwordValidationMessage;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: greenColor), // Green text color
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 250, 249, 249),
                          ),
                        ),
                        MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isRegisterHovered = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isRegisterHovered = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/registerPage');
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 16,
                                color: _isRegisterHovered ? greenColor : whiteColor,
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
}
