import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clubnorms/screens/authentication/SignInUsingEmail.dart';
import 'package:clubnorms/screens/authentication/UserController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Signupusingemail extends StatefulWidget {
  const Signupusingemail({super.key});

  @override
  State<Signupusingemail> createState() => _SignupusingemailState();
}

class _SignupusingemailState extends State<Signupusingemail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  var authSignUp = UserController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Helper function to validate email format
  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Helper function to validate username
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  // Helper function to validate passwords
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Validate matching passwords
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please re-enter password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Function to show a Snackbar with error message
  void _showSnackbar(String message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });
  }

  // Function to validate the form
  void _validateAndSignUp() {
    final emailError = _validateEmail(_emailController.text);
    final usernameError = _validateUsername(_usernameController.text);
    final passwordError = _validatePassword(_passwordController.text);
    final confirmPasswordError = _validateConfirmPassword(_rePasswordController.text);

    if (emailError != null) {
      _showSnackbar(emailError);
    } else if (usernameError != null) {
      _showSnackbar(usernameError);
    } else if (passwordError != null) {
      _showSnackbar(passwordError);
    } else if (confirmPasswordError != null) {
      _showSnackbar(confirmPasswordError);
    } else {
      // All validations passed, proceed with the sign-up logic
      String email = _emailController.text;
      String username = _usernameController.text;
      String password = _passwordController.text;
      handleSignUpWithEmail(email, password, username, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'CLUBNORMS',
                  style: TextStyle(
                    fontSize: 57,
                    fontFamily: 'MajorMonoDisplay',
                    color: Color.fromARGB(179, 0, 119, 178),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Get Started!',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Roboto',
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Icon(
                    Icons.add_a_photo,
                    size: 120,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(_emailController, 'Email', false),
                const SizedBox(height: 20),
                _buildTextField(_usernameController, 'Username', false),
                const SizedBox(height: 20),
                _buildTextField(_passwordController, 'Password', true),
                const SizedBox(height: 20),
                _buildTextField(_rePasswordController, 'Re-enter Password', true),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _validateAndSignUp,
                  child: Container(
                    width: double.infinity,
                    height: 51,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Signinusingemail()),
                    );
                  },
                  child: const Text(
                    'Already Have An Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
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

  // Helper function to build a text field
  Widget _buildTextField(TextEditingController controller, String label, bool obscure) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Future<User?> handleSignUpWithEmail(String email, String password, String username, BuildContext context) async {
    try {
      // Create user with email and password
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      final User user = result.user!;
      String? userId = user.uid;

      // Send email verification
      await user.sendEmailVerification();
      addUser(email, userId, username);
      print("Verification email has been sent to ${user.email}. Please check your inbox.");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A verification email has been sent. Please verify your email before logging in.'),
          backgroundColor: Colors.blue,
        ),
      );

      return user;
    } on FirebaseAuthException catch (e) {
      _showSnackbar(e.message ?? 'An error occurred, please try again.');
      print("Error: ${e.message}");
      return null;
    }
  }

  Future<bool> isEmailVerified() async {
    User? user = auth.currentUser;
    if (user != null) {
      await user.reload(); // Reload user data from Firebase
      return user.emailVerified;
    }
    return false;
  }

  addUser(String email, String userId, String username) {
    Map<String, String> data = {
      "email": email,
      "username": username,
      "userId": userId
    };

    return FirebaseFirestore.instance.collection('users').doc(userId).set(data)
        .then((value) => print("User added successfully!"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
