import 'package:flutter/material.dart';

class IMCTitle extends StatelessWidget {
  final String text;
  const IMCTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
