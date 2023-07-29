import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const WordCard({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
