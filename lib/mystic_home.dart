import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'fortunes.dart';

class MysticHomePage extends StatefulWidget {
  @override
  State<MysticHomePage> createState() => _MysticHomePageState();
}

class _MysticHomePageState extends State<MysticHomePage> {
  final List<String> _fortunes = mysticFortunes;

  String _currentFortune = "Shake your phone to get a mystic reading.";
  AccelerometerEvent? _lastEvent;
  final double shakeThreshold = 14.0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((event) {
      if (_lastEvent != null) {
        final dx = (event.x - _lastEvent!.x).abs();
        final dy = (event.y - _lastEvent!.y).abs();
        final dz = (event.z - _lastEvent!.z).abs();

        if (dx + dy + dz > shakeThreshold) {
          _revealFortune();
        }
      }
      _lastEvent = event;
    });
  }

  Future<void> _revealFortune() async {
    final fortune = _fortunes[Random().nextInt(_fortunes.length)];
    await _audioPlayer.play(AssetSource('sound/magic.wav'));
    setState(() {
      _currentFortune = fortune;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mystic 8-Ball"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade800,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset('assets/logo.png', height: 30),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade900, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Glowing 8-ball image
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.shade200,
                      blurRadius: 25,
                      spreadRadius: 6,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/8ball.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'Courier',
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                    key: ValueKey(_currentFortune),
                    animatedTexts: [
                      TyperAnimatedText(_currentFortune),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Shake to seek the truth...",
                style: TextStyle(color: Colors.white60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
