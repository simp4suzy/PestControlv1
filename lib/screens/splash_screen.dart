// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:pest_controlv1/screens/home_screen.dart'; 
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2100),
    );


    _controller.forward();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/pest_controlbg.gif',
            fit: BoxFit.cover,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedText('P', 0),
                _buildAnimatedText('e', 200),
                _buildAnimatedText('s', 400),
                _buildAnimatedText('t', 600),
                _buildAnimatedText('i', 800),
                _buildAnimatedText('f', 1000),
                _buildAnimatedText('y', 1200),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedText(String text, int delayMilliseconds) {
    return FadeTransition(
      opacity: _controller.drive(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).chain(
          CurveTween(
            curve: Interval(
              delayMilliseconds / 2100, // Delay ratio based on total duration
              1.0,
              curve: Curves.easeInOut,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}