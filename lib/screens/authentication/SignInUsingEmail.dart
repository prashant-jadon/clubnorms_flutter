import 'dart:ui';

import 'package:clubnorms/screens/authentication/SignUpUsingEmail.dart';
import 'package:clubnorms/screens/homescreen/bottomNavigationBar.dart';
import 'package:flutter/material.dart';

class Signinusingemail extends StatefulWidget {
  const Signinusingemail({super.key});

  @override
  State<Signinusingemail> createState() => _SigninusingemailState();
}

class _SigninusingemailState extends State<Signinusingemail> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: Colors.white,
          child: SafeArea(
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
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Email or Username',
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: false,
                      fillColor: Colors.black.withOpacity(0.2),
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
                      fillColor: Colors.black.withOpacity(0.2),
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
                    // Handle sign-in logic
                    print('Email: ${_emailController.text}');
                    print('Username: ${_usernameController.text}');
                    print('Password: ${_passwordController.text}');
                  },
                  child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Bottomnavigationbar()));
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
                  'Forgot your password ?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Signupusingemail()));
                  },
                  child: const Text(
                    'Dont Have An Account?',
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
}
