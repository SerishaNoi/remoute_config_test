import 'package:flutter/material.dart';

class InternerErroreScreen extends StatelessWidget {
  const InternerErroreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
            Text('Please, check your internet connection', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
