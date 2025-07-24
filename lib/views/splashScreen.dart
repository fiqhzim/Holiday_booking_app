// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, '/loginPage'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.purple.shade100,
        // color: const Color(0xff8A2BE2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tourism',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Text(
                'Package Booking',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}