
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Garamond',
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  // Variables for background gradient animation.
  List<Color> _colors = [
    const Color.fromARGB(255, 220, 165, 44),
    const Color.fromARGB(255, 239, 41, 41)
  ];
  bool _toggled = false;

  // Variables for button scale animation.
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the AnimationController for the button.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start an animation loop for the background gradient.
    Future.delayed(const Duration(seconds: 0), _animateBackground);
  }

  // Animate the background gradient by toggling the colors periodically.
  void _animateBackground() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        _toggled = !_toggled;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        // Animate the background gradient over 3 seconds.
        duration: const Duration(seconds: 3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _toggled
                ? [
              const Color.fromARGB(255, 166, 16, 16),
              const Color.fromARGB(255, 255, 193, 7)
            ]
                : _colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                // Animate button press (shrink a bit then return to normal)
                await _controller.reverse(); // shrink
                await _controller.forward(); // back to normal

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                print("Button Clicked");
              },
              child: const Text(
                "Click Here to Play Dice Game",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

