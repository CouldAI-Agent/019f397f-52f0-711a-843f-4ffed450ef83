import 'package:flutter/material.dart';
import 'dart:math' as math;

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isListening = false;
  String _statusText = 'Tap to speak';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        _statusText = 'Listening...';
        _animationController.duration = const Duration(milliseconds: 500);
        _animationController.repeat(reverse: true);
      } else {
        _statusText = 'Processing...';
        // Simulate processing then back to idle
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _statusText = 'Tap to speak';
              _animationController.duration = const Duration(milliseconds: 1500);
              _animationController.repeat(reverse: true);
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white70),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _statusText,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: _toggleListening,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isListening
                          ? Colors.teal.withOpacity(0.5 + (_animationController.value * 0.5))
                          : Colors.teal.withOpacity(0.2 + (_animationController.value * 0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.3 + (_animationController.value * 0.4)),
                          blurRadius: 30 + (_animationController.value * 40),
                          spreadRadius: 10 + (_animationController.value * 20),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
