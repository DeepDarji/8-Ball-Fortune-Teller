import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';

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
        primaryColor: Colors.deepPurple,
      ),
      home: MysticHomePage(),
    );
  }
}

class MysticHomePage extends StatefulWidget {
  @override
  State<MysticHomePage> createState() => _MysticHomePageState();
}

class _MysticHomePageState extends State<MysticHomePage> {
  final List<String> _fortunes = [
    "🔮 [Mysterious] The universe is aligning in your favor.",
    "🧠 [Wise] The answer lies within you.",
    "😅 [Funny] Ask again when my coffee kicks in.",
    "🦄 [Surreal] A rainbow-colored llama approves.",
    "🔮 [Mysterious] A shadow whispers... yes.",
    "🧠 [Wise] What you seek, seeks you.",
    "😅 [Funny] Outlook good... for someone else.",
    "🦄 [Surreal] The stars blinked — maybe.",
    "🔮 [Mysterious] Something strange is coming your way.",
    "🧠 [Wise] Fortune favors the bold.",
  ];

  String _currentFortune = "Shake to reveal your cosmic truth.";
  AccelerometerEvent? _lastEvent;
  final double shakeThreshold = 14.0;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Listen for shake
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

    // Play magic sound
    await _audioPlayer.play(AssetSource('sound/magic.wav'));

    // Set new fortune with animation
    setState(() {
      _currentFortune = fortune;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mystic 8-Ball", style: TextStyle(fontFamily: "Serif")),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent.shade200,
      ),
      body: Center(
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
                    color: Colors.deepPurpleAccent,
                    blurRadius: 25,
                    spreadRadius: 5,
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
              "🤲 Shake your phone for a reading",
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
