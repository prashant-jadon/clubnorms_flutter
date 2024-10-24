import 'dart:ui';
import 'package:clubnorms/screens/authentication/SignUpUsingEmail.dart';
import 'package:clubnorms/screens/authentication/UserController.dart';
import 'package:clubnorms/screens/homescreen/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';

class Signinusingemail extends StatefulWidget {
  const Signinusingemail({super.key});

  @override
  State<Signinusingemail> createState() => _SigninusingemailState();
}

class _SigninusingemailState extends State<Signinusingemail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Function to validate email and password
  void _validateAndSignIn(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Email regex pattern
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill in all fields.');
    } else if (!RegExp(emailPattern).hasMatch(email)) {
      _showSnackBar('Please enter a valid email address.');
    } else if (password.length < 8) {
      _showSnackBar('Password must be at least 8 characters long.');
    } else {
      // Handle successful sign-in
      handleSignInWithEmail(email, password, context);
    }
  }

  // Function to show SnackBar with a message after the current frame
  void _showSnackBar(String message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
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
                  'Welcome Back !',
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
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email or Username',
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: false,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: false,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _validateAndSignIn(context);  // Call the validation function when tapped
                  },
                  child: Container(
                    width: 316,
                    height: 51,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Signupusingemail()));
                  },
                  child: const Text(
                    'Don\'t Have An Account?',
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

  Future<void> handleSignInWithEmail(String email, String password, BuildContext context) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = result.user!;

      if(user.uid.isNotEmpty){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>new Bottomnavigationbar()));
      }
      // Check if the email is verified
      if (!user.emailVerified) {
        await user.sendEmailVerification(); // Send verification email
        _showSnackBar('A verification email has been sent. Please verify your email before logging in.');
        return; // Return without proceeding further
      }

      // Navigate to the next screen or update UI on successful login
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred. Please try again.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      _showSnackBar(message);
    } catch (e) {
      _showSnackBar('An unknown error occurred.');
    }
  }
}
