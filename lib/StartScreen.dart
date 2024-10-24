import 'dart:ui';

import 'package:clubnorms/screens/authentication/SignInUsingEmail.dart';
import 'package:clubnorms/screens/authentication/UserController.dart';
import 'package:clubnorms/screens/homescreen/bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Startscreen extends StatefulWidget {
  const Startscreen({super.key});

  @override
  State<Startscreen> createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundimage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'A product of Chandra Apps',
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'CLUBNORMS',
                    style: TextStyle(
                      fontSize: 57,
                      fontFamily: 'MajorMonoDisplay',
                      color: Color.fromARGB(179, 26, 175, 249),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Where \nMinds \nUnite for \nKnowledge!',
                    style: TextStyle(
                      fontSize: 66,
                      fontFamily: '.SF UI Text',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                          child: Container(
                              width: 316,
                              height: 51,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/signinusingemail.png"),
                                    fit: BoxFit.cover),
                              )),
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Signinusingemail()));

                          }),
                      const SizedBox(height: 10),
                      GestureDetector(
                          child: Container(
                              width: 316,
                              height: 51,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/signinusinggoogle.png"),
                                    fit: BoxFit.cover),
                              )),
                          onTap: () async {
                            //TODO: iOS signin with google not working
                            try{
                              final user = UserController.signInWithGoogle();
                              if(user!=null && mounted){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Bottomnavigationbar()));
                              }
                            }
                            on FirebaseAuthException catch(e){
                              print(e);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error occured")));
                            }
                            catch(e){
                              print(e);
                            }
                          }),
                      const SizedBox(height: 20),
                      const Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
