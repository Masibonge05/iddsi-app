import 'package:flutter/material.dart';

class Welcome2 extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const Welcome2({
    super.key,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: onNext,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black, // Optional: to fill space not covered by image
          child: const Center(
            child: Image(
              image: AssetImage('page1.jpg'),
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}