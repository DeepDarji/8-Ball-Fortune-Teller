import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ball_fortune/mystic_home.dart'; // Separate file for cleaner code

void main() {
  runApp(Mystic8BallApp());
}

class Mystic8BallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystic 8-Ball',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MysticHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Glowing logo
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.purpleAccent, blurRadius: 30, spreadRadius: 4),
                ],
              ),
              child: Image.asset('assets/logo.png'),
            ),
            SizedBox(height: 30),
            Text(
              "Mystic 8-Ball",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
                fontFamily: 'Georgia',
              ),
            )
          ],
        ),
      ),
    );
  }
}
