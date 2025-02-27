import 'package:flutter/material.dart';

class WordHeadline extends StatelessWidget {
  final String text;
  const WordHeadline({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
