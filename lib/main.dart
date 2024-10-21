import 'dart:ui';
import 'package:clubnorms/screens/authentication/SignInUsingEmail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clubnorm app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Clubnorm Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signinusingemail()));
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
                          onTap: () {
                            print("you clicked me");
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
